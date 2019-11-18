import 'package:firebase_example/authentication/authentication.dart';
import 'package:firebase_example/ui/activities/sign_in.dart';
import 'package:firebase_example/utils/root_activities.dart';
import 'package:flutter/material.dart';
import 'package:firebase_example/utils/colors_palette.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: ColorsPalette.primaryColor,
        cursorColor: ColorsPalette.primaryColor),
    home: RootActivities(Authentication()),
  ));
}
