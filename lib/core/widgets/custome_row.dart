import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class CustomeRow extends StatelessWidget {
  final IconData icon;
  final String text;
  IconData? editIcon;

  CustomeRow({Key? key, required this.icon, required this.text, this.editIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Row(
            children: [  
              Icon(
                icon,
                size: 20,
                color: orange,
              ),           
              Text(
                text,
                style: const TextStyle(
                    color: orange,
                    fontFamily: font,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Icon(
            editIcon,
            color: orange,
            size: 20,
          ),
        )
      ],
    );
  }
}
