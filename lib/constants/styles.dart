import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1.0),
  primarySwatch: Colors.blue,
  primaryColor: Color(0xff304080),
  inputDecorationTheme: inputDecorationTheme,
  cardTheme: cardTheme,
  buttonTheme: buttonTheme,
  cursorColor: Colors.indigo,
  accentColor: Colors.green,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: Colors.blue,
  primaryColor: Color(0xff304080),
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
  height: 44.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
  textTheme: ButtonTextTheme.primary,
);
