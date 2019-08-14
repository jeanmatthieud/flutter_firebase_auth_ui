import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth_ui/generated/i18n.dart';
import 'package:flutter_firebase_auth_ui/src/typedef.dart';
import 'package:flutter_firebase_auth_ui/src/utils.dart';

enum EmailPasswordWidgetState { SignIn, CreateAccount, ResetPassword }

class SignInEmailPasswordPage extends StatefulWidget {
  final LoggedInCallback onLoggedIn;

  SignInEmailPasswordPage({@required this.onLoggedIn});

  @override
  _SignInEmailPasswordPageState createState() => _SignInEmailPasswordPageState();
}

class _SignInEmailPasswordPageState extends State<SignInEmailPasswordPage> {
  EmailPasswordWidgetState _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = EmailPasswordWidgetState.SignIn;
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentState) {
      case EmailPasswordWidgetState.SignIn:
        return _SignInPage(
          onLoggedIn: widget.onLoggedIn,
          onCreateAccountPressed: () => setState(() => _currentState = EmailPasswordWidgetState.CreateAccount),
          onResetPasswordPressed: () => setState(() => _currentState = EmailPasswordWidgetState.ResetPassword),
        );
      case EmailPasswordWidgetState.CreateAccount:
        return _CreateAccountPage(onLoggedIn: widget.onLoggedIn);
      case EmailPasswordWidgetState.ResetPassword:
        return _ResetPasswordPage();
    }
    throw Exception('Unknown signin state');
  }
}

class _SignInPage extends StatefulWidget {
  final Function onCreateAccountPressed;
  final LoggedInCallback onLoggedIn;
  final Function onResetPasswordPressed;

  _SignInPage({@required this.onLoggedIn, @required this.onCreateAccountPressed, @required this.onResetPasswordPressed});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<_SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorCode;
  String _errorMessage;
  bool _loading = false;

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    I18n i18n = I18n.of(context);
    return AlertDialog(
      title: Text(i18n.signIn),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(width: MediaQuery.of(context).size.width),
              if (_errorCode != null) Text(i18nErrorCode(context, _errorCode), style: TextStyle(color: Colors.red)),
              TextFormField(
                enabled: !_loading,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(labelText: i18n.email),
                validator: (String value) {
                  if (value.isEmpty) {
                    return i18n.emailFieldEmpty;
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: !_loading,
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(labelText: i18n.password),
                validator: (String value) {
                  if (value.isEmpty) {
                    return i18n.passwordFieldEmpty;
                  }
                  return null;
                },
              ),
              Align(
                child: FlatButton(
                  child: Text(i18n.forgottenPassword, style: TextStyle(color: Colors.blueGrey)),
                  onPressed: widget.onResetPasswordPressed,
                ),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Visibility(visible: _loading, child: Container(height: 10, width: 10, child: CircularProgressIndicator(strokeWidth: 2))),
        FlatButton(
          child: Text(i18n.register),
          onPressed: _loading ? null : () => widget.onCreateAccountPressed(),
        ),
        FlatButton(
          onPressed: _loading ? null : () => _validate(),
          child: Text(i18n.signIn),
        )
      ],
    );
  }

  void _validate() async {
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          _loading = true;
        });

        AuthResult authResult = await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
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
        setState(() {
          _loading = false;
        });
      }
    }
  }
}

class _CreateAccountPage extends StatefulWidget {
  final LoggedInCallback onLoggedIn;

  _CreateAccountPage({@required this.onLoggedIn});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<_CreateAccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController = TextEditingController();
  String _errorCode;
  bool _loading = false;

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    _passwordRepeatController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    I18n i18n = I18n.of(context);
    return AlertDialog(
      title: Text(i18n.register),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(width: MediaQuery.of(context).size.width),
              if (_errorCode != null) Text(i18nErrorCode(context, _errorCode), style: TextStyle(color: Colors.red)),
              TextFormField(
                enabled: !_loading,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(labelText: i18n.email),
                validator: (String value) {
                  if (value.isEmpty) {
                    return i18n.emailFieldEmpty;
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: !_loading,
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(labelText: i18n.password),
                validator: (String value) {
                  if (value.isEmpty) {
                    return i18n.passwordFieldEmpty;
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: !_loading,
                obscureText: true,
                controller: _passwordRepeatController,
                decoration: InputDecoration(labelText: i18n.repeatPassword),
                validator: (String value) {
                  if (value.isEmpty) {
                    return i18n.repeatPasswordFieldEmpty;
                  }
                  if (value != _passwordController.text) {
                    return i18n.passwordsDontMatch;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Visibility(visible: _loading, child: Container(height: 10, width: 10, child: CircularProgressIndicator(strokeWidth: 2))),
        FlatButton(
          onPressed: _loading ? null : () => _validate(),
          child: Text(i18n.create),
        )
      ],
    );
  }

  void _validate() async {
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          _loading = true;
        });

        AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
        widget.onLoggedIn(authResult);
      } on PlatformException catch (e) {
        print(e);
        setState(() {
          _errorCode = e.code;
        });
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }
}

class _ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<_ResetPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String _errorCode;
  bool _loading = false;
  bool _success = false;

  @override
  void dispose() {
    _emailController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    I18n i18n = I18n.of(context);
    return AlertDialog(
      title: Text(i18n.forgottenPassword),
      content: SingleChildScrollView(
        child: _success
            ? Text(
                i18n.passwordResetSuccess,
                style: TextStyle(color: Colors.green),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(width: MediaQuery.of(context).size.width),
                    if (_errorCode != null) Text(i18nErrorCode(context, _errorCode), style: TextStyle(color: Colors.red)),
                    TextFormField(
                      enabled: !_loading,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(labelText: i18n.email),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return i18n.emailFieldEmpty;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
      ),
      actions: _success
          ? null
          : <Widget>[
              Visibility(visible: _loading, child: Container(height: 10, width: 10, child: CircularProgressIndicator(strokeWidth: 2))),
              FlatButton(
                onPressed: _loading ? null : () => _validate(),
                child: Text(i18n.reset),
              )
            ],
    );
  }

  void _validate() async {
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          _loading = true;
        });

        await _auth.sendPasswordResetEmail(email: _emailController.text);

        setState(() {
          _errorCode = null;
          _success = true;
        });
      } on PlatformException catch (e) {
        print(e);
        setState(() {
          _errorCode = e.code;
        });
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }
}
