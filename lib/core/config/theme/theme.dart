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
        borderSide: BorderSide(color: orange, width: 1.0),
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
    textTheme: TextTheme(
        headlineSmall: const TextStyle(
            color: beg,
            fontFamily: font,
            fontSize: 18,
            fontWeight: FontWeight.normal),
        headlineMedium: const TextStyle(
            color: beg,
            fontFamily: font,
            fontSize: 24,
            fontWeight: FontWeight.normal,),
      headlineLarge: const TextStyle(
            color: beg,
            fontFamily: font,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        bodySmall: const TextStyle(
            color: orange,
            fontFamily: font,
            fontSize: 18,
            fontWeight: FontWeight.normal),
        bodyMedium: const TextStyle(
            color: orange,
            fontFamily: font,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        bodyLarge: const TextStyle(
            color: beg,
            fontFamily: font,
            fontSize: 24,
            fontWeight: FontWeight.normal),
           
            ),
             
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(beg),
      trackColor: MaterialStateProperty.all(darkBlue),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style:ElevatedButton.styleFrom(
          primary: orange,
         ),),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: orange,
        contentTextStyle: TextStyle(
          fontFamily: font,
          fontSize: 14,
        )));
  // )

