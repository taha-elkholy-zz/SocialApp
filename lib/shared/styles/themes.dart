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
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'Jannah',
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: defaultColor),
    ),
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
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Jannah',
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: defaultColor),
    ),
  ),
);
