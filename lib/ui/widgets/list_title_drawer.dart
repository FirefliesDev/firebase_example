import 'package:firebase_example/utils/colors_palette.dart';
import 'package:flutter/material.dart';

class ListTitleDrawer extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color; 
  final VoidCallback onTap;

  ListTitleDrawer({@required this.text, this.icon, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: icon != null
          ? Align(
              alignment: Alignment(-1.2, 0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            )
          : Text(
              text,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
      leading: icon != null
          ? Icon(
              icon,
              color: ColorsPalette.textColorDark,
            )
          : null,
      onTap: onTap ?? (){},
    );
  }
}
