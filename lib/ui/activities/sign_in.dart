import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/authentication/base_auth.dart';
import 'package:firebase_example/ui/widgets/google_button.dart';
import 'package:firebase_example/ui/widgets/progress_indicator_modal.dart';
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
  String _emailValue, _passwordValue;
  bool _isObscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  /// Creates a Scaffold
  Widget _buildScaffold() {
    final _title = Text(
      'MyPRESENCE',
      style: TextStyle(
          color: ColorsPalette.primaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 24),
    );

    final _email = TextFormField(
      validator: (input) => input.isEmpty ? 'Email can\'t be empty' : null,
      // onSaved: (input) => _emailText = input,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(
          Icons.mail_outline,
          color: ColorsPalette.primaryColor,
        ),
      ),
    );

    final _password = TextFormField(
      validator: (input) => input.isEmpty ? 'Password can\'t be empty' : null,
      // onSaved: (input) => _passwordText = input,
      obscureText: _isObscureText,
      decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: ColorsPalette.primaryColor,
          ),
          suffixIcon: _isObscureText
              ? IconButton(
                  onPressed: _toggleIcon,
                  icon: Icon(Icons.visibility_off),
                  color: ColorsPalette.primaryColor,
                )
              : IconButton(
                  onPressed: _toggleIcon,
                  icon: Icon(Icons.visibility),
                  color: ColorsPalette.primaryColor,
                )),
    );

    final _labelDontHaveAccount = Text(
      "Don't have an account?",
      style: TextStyle(color: ColorsPalette.textColorDark, fontSize: 16),
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
      'or',
      style: TextStyle(color: ColorsPalette.textColorDark, fontSize: 14),
    );

    final _body = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
          child: _title,
        ),
        _email,
        _password,
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: _buildFlatButton(
              color: ColorsPalette.primaryColor, name: 'Sign in', onTap: () {}),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_labelDontHaveAccount, _buttonSignUp],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  color: ColorsPalette.textColorDark50,
                ),
              )),
              _label,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Divider(
                    color: ColorsPalette.textColorDark50,
                  ),
                ),
              ),
            ],
          ),
        ),
        GoogleButton(
          onTap: _signInWithGoogle,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: ColorsPalette.backgroundColorLight,
      body: ProgressIndicatorModal(
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                height: 30,
                color: ColorsPalette.primaryColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: _body,
              )
            ],
          )),
        ),
        inAsyncCall: _isLoading,
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

  /// Sign the user with Google
  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        _isLoading = true;
      });
      debugPrint('Logging in with Google...');
      widget.onSignedIn(await widget.auth.signInWithGoogle());
    } catch (e) {
      debugPrint('Error Google: ' + e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Called when the user press the icon eye
  void _toggleIcon() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }
}
