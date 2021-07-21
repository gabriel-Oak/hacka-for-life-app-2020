import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final primaryColor = Color(0xFF03A9F4);
final accentColor = Color(0xFF6200EE);

final theme = ThemeData(
    primaryColor: primaryColor,
    accentColor: accentColor,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: primaryColor,
        elevation: 0,
        textTheme:
            TextTheme(title: TextStyle(color: Colors.white, fontSize: 18))),
    inputDecorationTheme: fieldTheme,
    cursorColor: accentColor);

final fieldTheme = InputDecorationTheme(
  fillColor: primaryColor,
  labelStyle: TextStyle(color: primaryColor),
);
