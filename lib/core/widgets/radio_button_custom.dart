import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int value = 0;
  @override
  Widget CustomRadioButton(String text, int index) {
    return SizedBox(
      width: 230,
      height: 40,
      child: OutlinedButton(
          onPressed: () {
            setState(() {
              value = index;
            });
          },
          child: Text(
            text,
            style: TextStyle(
              color: (value == index) ? beg : karmedi,
              fontFamily: font,
              fontSize: 24,
            ),
          ),
          style: OutlinedButton.styleFrom(
              side: const BorderSide(
                  color: beg, width: 1.4, style: BorderStyle.solid))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomRadioButton("Company", 1),
        sizedBoxMedium,
        CustomRadioButton("Engineer", 2),
        sizedBoxMedium,
        CustomRadioButton("Client", 3)
      ],
    );
  }
}
