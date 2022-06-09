import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class TaskStateCard extends StatelessWidget {
  final Function()? onTap;
  final bool isSelected;
  final String title;
  const TaskStateCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
            color: (isSelected) ? orange : darkBlue,
            border:
                Border.all(color: (isSelected) ? darkBlue : orange, width: 2.5),
            borderRadius: BorderRadius.circular(8)),
        child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
