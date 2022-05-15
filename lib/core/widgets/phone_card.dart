import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class PhoneCard extends StatelessWidget {
  String text;
  Function()? onTap;
  PhoneCard({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 50,
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(82, 246, 218, 146),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
      Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: onTap,
            child: const CircleAvatar(
              backgroundColor: orange,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              ),
              radius: 10,
            ),
          ))
    ]);
  }
}
