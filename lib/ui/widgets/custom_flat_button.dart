import 'package:firebase_example/utils/colors_palette.dart';
import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String name;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  CustomFlatButton(
      {this.name, this.color, this.textColor, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
          onPressed: onTap == null ? () {} : onTap,
          child: Text(
            name,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
          textColor: ColorsPalette.textColorLight,
          color: color ?? ColorsPalette.primaryColor),
    );
  }
}
