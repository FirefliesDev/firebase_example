import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/authentication/base_auth.dart';
import 'package:firebase_example/utils/colors_palette.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final FirebaseUser currentUser;

  Home({this.auth, this.currentUser, this.onSignedOut});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  /// Creates a Scaffold
  Widget _buildScaffold() {
    return Scaffold(
        appBar: AppBar(

            /// If [title] doesn't has value, then set a default title
            title: Text(
              'Home',
              style: TextStyle(color: ColorsPalette.textColorLight),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Logout'),
                onPressed: (_signedOut),
              )
            ]),
        backgroundColor: ColorsPalette.backgroundColorLight,
        body: Center(
          child: Text(widget.currentUser.displayName),
        ));
  }

  ///
  void _signedOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
