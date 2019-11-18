import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/authentication/base_auth.dart';
import 'package:firebase_example/utils/colors_palette.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final BaseAuth auth;
  final void Function(FirebaseUser) onSignedIn;

  SignIn({@required this.auth, @required this.onSignedIn});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  /// Creates a Scaffold
  Widget _buildScaffold() {
    final _title = Text(
      'FIREFLIES ACCOUNT',
      style: TextStyle(
          color: ColorsPalette.primaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 24),
    );

    final _subtitle = Text(
      'Manage your presence',
      style: TextStyle(
          color: ColorsPalette.textColorDark,
          fontWeight: FontWeight.w300,
          fontSize: 16),
    );

    final _email = TextFormField(
      validator: (input) => input.isEmpty ? 'Email can\'t be empty' : null,
      // onSaved: (input) => _emailText = input,
      decoration: InputDecoration(labelText: 'Email'),
    );

    final _password = TextFormField(
      validator: (input) => input.isEmpty ? 'Password can\'t be empty' : null,
      // onSaved: (input) => _passwordText = input,
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
    );

    final _buttonSignUp = FlatButton(
      onPressed: () {},
      child: Text(
        'Sign Up',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: ColorsPalette.primaryColor,
            fontSize: 16),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final _label = Text(
      'or sign in with',
      style: TextStyle(color: ColorsPalette.textColorDark, fontSize: 14),
    );

    final _body = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
          child: _title,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: _subtitle,
        ),
        _email,
        _password,
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 5.0),
          child: _buildFlatButton(
              color: ColorsPalette.primaryColor, name: 'Sign in', onTap: () {}),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Don't have an account?",
              style:
                  TextStyle(color: ColorsPalette.textColorDark, fontSize: 16),
            ),
            _buttonSignUp
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: ColorsPalette.textColorDark50,
                ),
              )),
              _label,
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: ColorsPalette.textColorDark50,
                ),
              )),
            ],
          ),
        ),
        _buildFlatButton(
            color: ColorsPalette.accentColor,
            name: 'Google',
            onTap: _signInWithGoogle),
        // TODO: Create a Google Sign In Button
      ],
    );

    return Scaffold(
      backgroundColor: ColorsPalette.backgroundColorLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child: _body,
          ),
        ),
      ),
    );
  }

  /// Creates a flat button
  Widget _buildFlatButton(
      {String name, Color color, Color textColor, VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
          onPressed: onTap == null ? () {} : onTap,
          child: Text(
            name,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
          textColor: ColorsPalette.textColorLight,
          color: color),
    );
  }

  ///
  Future<void> _signInWithGoogle() async {
    try {
      // setState(() {
      //   _isLogging = true;
      // });
      debugPrint('Logging in with Google...');
      widget.onSignedIn(await widget.auth.signInWithGoogle());
    } catch (e) {
      debugPrint('Error Google: ' + e.toString());
    } finally {
      // setState(() {
      //   _isLogging = false;
      // });
    }
  }
}
