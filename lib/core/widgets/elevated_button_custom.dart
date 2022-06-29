import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatefulWidget {
  final String text;
  final Function()? onPressed;
  final Color bgColor;
  const ElevatedButtonCustom(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.bgColor})
      : super(
          key: key,
        );

  @override
  State<ElevatedButtonCustom> createState() => _ElevatedButtonCustomState();
}

class _ElevatedButtonCustomState extends State<ElevatedButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 30,
        child: ElevatedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(style: BorderStyle.solid, color: widget.bgColor),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(widget.bgColor),
          ),
          onPressed: widget.onPressed,
          child:
              Text(widget.text, style: Theme.of(context).textTheme.bodySmall),
        ));
  }
}
