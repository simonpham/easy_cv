import 'package:easy_cv/assets.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1.0),
  primarySwatch: Colors.indigo,
  primaryColor: Color(0xff304080),
  fontFamily: Fonts.raleway,
  inputDecorationTheme: inputDecorationTheme,
  cardTheme: cardTheme,
  buttonTheme: buttonTheme,
  cursorColor: Colors.indigo,
  accentColor: Colors.green,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: Colors.indigo,
  primaryColor: Color(0xff304080),
  fontFamily: Fonts.raleway,
  inputDecorationTheme: inputDecorationTheme,
  cardTheme: cardTheme.copyWith(color: Colors.black),
  buttonTheme: buttonTheme,
  cursorColor: Colors.indigo,
  accentColor: Colors.green,
);

final inputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
  border: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.indigo),
    borderRadius: BorderRadius.circular(36.0),
  ),
);

final cardTheme = CardTheme(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
);

final buttonTheme = ButtonThemeData(
  buttonColor: Colors.white,
  height: 56.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
  textTheme: ButtonTextTheme.primary,
);
