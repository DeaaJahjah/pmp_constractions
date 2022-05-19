

import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class NumberTextField extends StatelessWidget {
  TextEditingController controller ;
  Function() onPressed;


  NumberTextField ({Key? key,required this.controller,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 230,
                  height: 40,
                  child: TextFormField(
                    controller:controller,
                    decoration:  InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(14),
                      label: Text(
                        context.loc.number,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      alignLabelWithHint: true,
                    ),
                    textAlign: TextAlign.start,
                    autofocus: false,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: IconButton(
                      onPressed:onPressed,
                      icon: const Icon(
                        Icons.add,
                        size: 15,
                        color: beg,
                      )),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            );
  }
}