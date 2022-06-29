import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

Future<DateTime?> pickDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2050),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
                  onPrimary: darkBlue, // selected text color
                  onSurface: beg, // default text color
                  primary: beg,
                  background: beg // circle color
                  )
              .copyWith(
            secondary: darkBlue,
            surface: const Color.fromARGB(255, 8, 22, 42),
            onSurface: beg,
            onPrimary: darkBlue,
          ),
          dialogBackgroundColor: darkBlue,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      color: beg,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      fontFamily: font),
                  primary: beg, // color of button's letters
                  backgroundColor: darkBlue, // Background color
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50)))),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    return picked;
  }
  return null;
}
