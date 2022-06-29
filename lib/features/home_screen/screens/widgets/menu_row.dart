import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class MenuRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const MenuRow({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
            color: orange,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
