import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  const SearchTextField(
      {Key? key, required this.onChanged, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            fillColor: Color.fromARGB(15, 11, 29, 55),
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            hintText: 'Search',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          controller: controller,
          onChanged: onChanged),
    );
  }
}
