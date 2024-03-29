import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/ui/widgets/list_title_drawer.dart';
import 'package:firebase_example/utils/colors_palette.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  // final PageController _pageController;
  final FirebaseUser user;
  final String email;
  final String photoUrl;
  final String _emptyPhotoURL =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
  final VoidCallback onSignedOut;

  NavigationDrawer(
      {@required this.user, this.email, this.photoUrl, this.onSignedOut});

  @override
  Widget build(BuildContext context) {
    // print('${user.toString()}');
    final _background = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
            ColorsPalette.backgroundColorLight,
            ColorsPalette.backgroundColorLight
          ])),
    );

    return Drawer(
        child: SafeArea(
      child: Stack(
        children: <Widget>[
          _background,
          ListView(
            children: <Widget>[
              Container(
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.only(bottom: 0.0),
                  decoration: BoxDecoration(
                      color: ColorsPalette.backgroundColorLight,
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0x15000000)))),
                  currentAccountPicture: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: ColorsPalette.backgroundColorLight,
                    backgroundImage: NetworkImage(
                        user.photoUrl != null ? photoUrl : _emptyPhotoURL),
                  ),
                  accountEmail: Text(
                    email,
                    style: TextStyle(
                        color: ColorsPalette.textColorDark, fontSize: 16.0),
                  ),
                  accountName: Text(
                    user.displayName == null ? '' : user.displayName,
                    style: TextStyle(
                        color: ColorsPalette.textColorDark,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              ListTitleDrawer(
                text: 'Profile',
                icon: Icons.person,
              ),
              ListTitleDrawer(
                text: 'Watchlist',
                icon: Icons.bookmark,
              ),
              ListTitleDrawer(
                text: 'Reviews',
                icon: Icons.edit,
              ),
              Container(
                height: 1.25,
                color: ColorsPalette.backgroundColorLightGray,
              ),
              ListTitleDrawer(
                text: 'Settings',
              ),
              ListTitleDrawer(
                text: 'About MyPresence',
              ),
              Container(
                height: 1.25,
                color: ColorsPalette.backgroundColorLightGray,
              ),
              ListTitleDrawer(
                text: 'Logout',
                onTap: (){
                  onSignedOut();
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    ));
  }
}
