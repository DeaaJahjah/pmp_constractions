import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color bgColor;
  const ElevatedButtonCustom(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.bgColor})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 30,
        child: ElevatedButton( 
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(style: BorderStyle.solid, color: color),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          ),
          onPressed: onPressed(),
          child: Text(
            text,
            style: const TextStyle(
                color: orange,
                fontFamily: font,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
        ));
  }
}
