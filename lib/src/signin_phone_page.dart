import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth_ui/generated/i18n.dart';
import 'package:flutter_firebase_auth_ui/src/utils.dart';
import 'package:flutter_firebase_auth_ui/src/typedef.dart';

enum SignInPhoneWidgetState { EnterPhoneNumber, RequestSent, CodeSent, Complete, Failed, CodeAutoRetrievalTimeout }

class SignInPhonePage extends StatefulWidget {
  final LoggedInCallback onLoggedIn;

  SignInPhonePage({@required this.onLoggedIn});

  @override
  _SignInPhonePageState createState() => _SignInPhonePageState();
}

class _SignInPhonePageState extends State<SignInPhonePage> {
  SignInPhoneWidgetState _currentState;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TODO: improve to be able to define a default code country
  final TextEditingController _phoneController = TextEditingController(text: '+33');
  final Duration _timeoutDuration = Duration(seconds: 75);
  String _errorCode;
  String _errorMessage;
  Timer _currentTimer;
  int _currentTick = 0;

  @override
  void initState() {
    super.initState();
    _currentState = SignInPhoneWidgetState.EnterPhoneNumber;
  }

  @override
  void dispose() {
    _currentTimer?.cancel();
    _phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    I18n i18n = I18n.of(context);
    return AlertDialog(
      title: Text(i18n.signIn),
      content: SingleChildScrollView(
        child: _buildBody(context),
      ),
      actions: <Widget>[
        Visibility(
          visible: [SignInPhoneWidgetState.RequestSent, SignInPhoneWidgetState.CodeSent].contains(_currentState),
          child: Text(
            '${_timeoutDuration.inSeconds - _currentTick}',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Visibility(
          visible: _currentState == SignInPhoneWidgetState.EnterPhoneNumber,
          child: FlatButton(
            onPressed: _validate,
            child: Text(i18n.check),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    I18n i18n = I18n.of(context);
    switch (_currentState) {
      case SignInPhoneWidgetState.EnterPhoneNumber:
        return _buildForm(context);
      case SignInPhoneWidgetState.RequestSent:
        return _buildProgress(context, i18n.codeRequestInProgress);
      case SignInPhoneWidgetState.CodeSent:
        return _buildProgress(context, i18n.codeRequestSent);
      case SignInPhoneWidgetState.Complete:
        return _buildProgress(context, i18n.codeCheckedAuthInProgress);
      case SignInPhoneWidgetState.Failed:
        return _buildError(context, i18nErrorCode(context, _errorCode));
      case SignInPhoneWidgetState.CodeAutoRetrievalTimeout:
        return _buildError(context, i18n.unableToVerifyCode);
    }
    throw Exception('Unknown signin state');
  }

  Widget _buildError(BuildContext context, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(child: Icon(Icons.error_outline, color: Colors.red, size: 80), padding: EdgeInsets.symmetric(vertical: 8)),
        Padding(child: Text(text, textAlign: TextAlign.center), padding: EdgeInsets.only(top: 16)),
      ],
    );
  }

  Widget _buildProgress(BuildContext context, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(child: Container(child: CircularProgressIndicator(strokeWidth: 7), width: 80, height: 80), padding: EdgeInsets.symmetric(vertical: 8)),
        Padding(child: Text(text, textAlign: TextAlign.center), padding: EdgeInsets.only(top: 16)),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    I18n i18n = I18n.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            decoration: InputDecoration(prefixIcon: Icon(Icons.phone)),
            validator: (String value) {
              if (value.isEmpty) {
                return i18n.phoneFieldEmpty;
              }
              if (!_phoneNumberValidator(value)) {
                return i18n.phoneFormatError;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _validate() async {
    if (_formKey.currentState.validate()) {
      _currentTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _currentTick = timer.tick;
        });
      });

      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text,
        timeout: _timeoutDuration,
        codeAutoRetrievalTimeout: (String verificationId) {
          _currentTimer.cancel();
          setState(() {
            _currentState = SignInPhoneWidgetState.CodeAutoRetrievalTimeout;
          });
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          setState(() {
            _currentState = SignInPhoneWidgetState.CodeSent;
          });
        },
        verificationCompleted: (AuthCredential phoneAuthCredential) async {
          setState(() {
            //_currentState = SignInPhoneWidgetState.Complete;
          });

          try {
            AuthResult authResult = await _auth.signInWithCredential(phoneAuthCredential);
            widget.onLoggedIn(authResult);
          } on PlatformException catch (e) {
            print(e);
            setState(() {
              _errorCode = e.code;
              _errorMessage = e.message;
            });
          } catch (e) {
            print(e);
          } finally {
            _currentTimer.cancel();
          }
        },
        verificationFailed: (AuthException error) {
          _currentTimer.cancel();
          setState(() {
            _errorCode = error.code;
            _errorMessage = error.message;
            _currentState = SignInPhoneWidgetState.Failed;
          });
        },
        //forceResendingToken:
      );
    }
  }

  // TODO: improve to match every country phone format
  bool _phoneNumberValidator(String value) {
    Pattern pattern = r'^\+[0-9]{11}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}
