import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class CustomItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool selected;
  final Function() onTap;

  const CustomItem(
      {Key? key,
      required this.text,
      this.icon,
      required this.selected,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: (selected) ? orange : darkBlue,
            border:
                Border.all(color: (selected) ? darkBlue : orange, width: 2.5),
            borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (icon == null)
              const SizedBox(
                width: 20,
              )
          ],
        ),
      ),
    );
  }
}
