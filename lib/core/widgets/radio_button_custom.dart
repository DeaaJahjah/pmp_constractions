import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class CustomeRadioButton extends StatelessWidget {
  final String text;
  final int value;
  final int index;
  final Function()? onPressed;

  const CustomeRadioButton(
      {Key? key,
      required this.text,
      required this.value,
      required this.index,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 40,
      child: OutlinedButton(
          onPressed: onPressed,
          child: Text(text,
              style: (value == index)
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.headlineMedium),
          style: OutlinedButton.styleFrom(
              side: const BorderSide(
                  color: beg, width: 1.4, style: BorderStyle.solid))),
    );
  }
}
