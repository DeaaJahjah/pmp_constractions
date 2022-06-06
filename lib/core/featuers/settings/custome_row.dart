import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';


class CustomeRow extends StatelessWidget {
  IconData icon;
  String text;
  CustomeRow({Key? key, required this.icon, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        sizedBoxMedium,
        Icon(icon),
        sizedBoxLarge,
        Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
