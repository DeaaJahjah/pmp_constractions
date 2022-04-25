import 'package:flutter/material.dart';

customeAppBar({String? title}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    title: Text(title!),
  );
}
