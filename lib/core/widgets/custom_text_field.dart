import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class TextFieldCustome extends StatelessWidget {
  String text;
  Function(String? value) onSaved;

  TextFieldCustome({
    Key? key,
    required this.text,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: TextFormField(
        onSaved: onSaved,
        cursorHeight: 22,
        cursorColor: karmedi,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(14),
          labelStyle: Theme.of(context).textTheme.headlineSmall,
          label: Text(text),
          alignLabelWithHint: true,
        ),
        textAlign: TextAlign.start,
        autofocus: false,
        style: const TextStyle(color: karmedi),
      ),
    );
  }
}
