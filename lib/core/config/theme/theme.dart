import 'package:flutter/material.dart';

const Color darkBlue = Color(0xff0b1d37);
const Color orange = Color(0xffF68D32);
const Color karmedi = Color(0xffD6744E);
const Color beg = Color(0xffF6D992);
const Color white = Color(0xffffffff);
const String font = 'TitilliumWeb';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: white,
  backgroundColor: white,
  scaffoldBackgroundColor: white,
  appBarTheme: const AppBarTheme(
      color: white,
      titleTextStyle: TextStyle(
          color: darkBlue,
          fontFamily: font,
          fontSize: 26,
          fontWeight: FontWeight.bold)),
  textTheme: const TextTheme(
      headlineMedium: TextStyle(
          color: darkBlue,
          fontFamily: font,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          color: darkBlue,
          fontFamily: font,
          fontSize: 20,
          fontWeight: FontWeight.normal)),
  iconTheme: const IconThemeData(color: orange),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkBlue,
  backgroundColor: darkBlue,
  scaffoldBackgroundColor: darkBlue,
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: beg, width: 1.0),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: karmedi, width: 1.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: darkBlue,
    titleTextStyle: TextStyle(
        color: beg,
        fontFamily: font,
        fontSize: 26,
        fontWeight: FontWeight.bold),
  ),
  textTheme: const TextTheme(
      headlineMedium: TextStyle(
          color: beg,
          fontFamily: font,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          color: beg,
          fontFamily: font,
          fontSize: 18,
          fontWeight: FontWeight.normal),
      headlineLarge: TextStyle(
          color: beg,
          fontFamily: font,
          fontSize: 28,
          fontWeight: FontWeight.normal)),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(beg),
    trackColor: MaterialStateProperty.all(darkBlue),
  ),
  iconTheme: const IconThemeData(color: orange),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: karmedi,
          textStyle: const TextStyle(
            fontFamily: font,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: beg,
          ))),
);

  // )

