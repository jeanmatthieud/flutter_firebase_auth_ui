# flutter_firebase_auth_ui

This project will help you build simple and light UI to sign-in users.
No big dependencies!

/!\ This library is used in some of my apps and it will be updated as and when needed :)
PR are welcome!

### Sign-in button list
This package doesn't (yet) include simple buttons to sign-in users.
I will advise you to use [flutter_signin_button](https://pub.dev/packages/flutter_signin_button).

```dart
// Google Auth
SignInButton(Buttons.Google, onPressed: _signInWithGoogle)
// Email
SignInButtonBuilder(
  icon: Icons.email,
  text: 'Sign-in with email',
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) {
        return SignInEmailPasswordPage(onLoggedIn: () {
          Navigator.of(context).pop();
        });
      },
    );
  },
  backgroundColor: Colors.blueGrey[700],
)
// Phone
SignInButtonBuilder(
  icon: Icons.phone,
  text: 'Sign-in with phone',
  onPressed: _signInWithPhone,
  backgroundColor: Colors.blueGrey[700],
)
```

### Google Auth
Requires [firebase_auth](https://pub.dev/packages/firebase_auth).
Please follow the installation instructions.
Does NOT requires this plugin, as the UI is part of the firebase_auth plugin.

```dart
Future<FirebaseUser> _signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult result = await _auth.signInWithCredential(credential);
    return result?.user;
  }
  return null;
}
```

### Email
```dart
showDialog(
  context: context,
  builder: (context) {
    return SignInPhonePage(onLoggedIn: () {
      Navigator.of(context).pop();
    });
  },
);
```