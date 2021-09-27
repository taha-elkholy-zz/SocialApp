import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleSpacing: 20,
    titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        color: defaultColor,
        fontSize: 20,
        fontWeight: FontWeight.bold),

    actionsIconTheme: IconThemeData(
      color: defaultColor,
    ),
    iconTheme: IconThemeData(
      color: defaultColor,
    ),
    elevation: 0,
    // control of status bar color
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleSpacing: 20,
    titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        color: defaultColor,
        fontSize: 20,
        fontWeight: FontWeight.bold),

    actionsIconTheme: IconThemeData(
      color: defaultColor,
    ),
    iconTheme: IconThemeData(
      color: defaultColor,
    ),
    elevation: 0,
    // control of status bar color
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.black,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.white54,
    elevation: 20,
  ),
);
