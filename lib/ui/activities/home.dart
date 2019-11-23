import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/authentication/base_auth.dart';
import 'package:firebase_example/database/firebase_service.dart';
import 'package:firebase_example/models/item.dart';
import 'package:firebase_example/ui/widgets/custom_flat_button.dart';
import 'package:firebase_example/ui/widgets/navigation_drawer.dart';
import 'package:firebase_example/utils/colors_palette.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        backgroundColor: ColorsPalette.backgroundColorLight,
        appBar: _buildAppBar(),
        drawer: NavigationDrawer(
          user: widget.currentUser,
          email: widget.currentUser.email,
          photoUrl: widget.currentUser.photoUrl,
          onSignedOut: _signedOut,
        ),
        body: _buildBody());
  }

  ///
  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomFlatButton(
          name: 'Create Record',
          onTap: _create,
        ),
        CustomFlatButton(
          name: 'View Record',
          onTap: _read,
        ),
        CustomFlatButton(
          name: 'Update Record',
          onTap: _updateEvent,
        ),
        CustomFlatButton(
          name: 'Delete Record',
          onTap: _deleteEvent,
        ),
      ],
    );
  }

  ///
  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Home',
        style: TextStyle(color: ColorsPalette.textColorLight),
      ),
      iconTheme: IconThemeData(color: ColorsPalette.textColorLight),
    );
  }

  ///
  Future<void> _create() async {
    await FirebaseService.create(
        Item(title: 'Item', description: 'My description'));

    Fluttertoast.showToast(
        msg: "Item created!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        fontSize: 16.0);
  }

  Future<void> _read() async {
    var result = (await FirebaseService.read()).asMap();

    Fluttertoast.showToast(
        msg: '${result[0].description}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        fontSize: 16.0);
  }

  Future<void> _updateEvent() async {
    await FirebaseService.update(Item(
        id: '-LuKXfotiwOOOfahZKa_',
        title: 'New Title',
        description: 'New Description'));

    Fluttertoast.showToast(
        msg: "Done!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        fontSize: 16.0);
  }

  Future<void> _deleteEvent() async {
    await FirebaseService.delete('-LuKXfotiwOOOfahZKa_');
    Fluttertoast.showToast(
        msg: "Done!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        fontSize: 16.0);
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
