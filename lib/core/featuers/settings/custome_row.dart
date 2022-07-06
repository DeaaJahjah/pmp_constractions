import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

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
        Icon(icon, color: orange),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
