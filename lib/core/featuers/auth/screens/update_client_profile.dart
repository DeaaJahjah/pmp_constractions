import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';

class UpdateClientProfileScreen extends StatefulWidget {
  Client? client;
  UpdateClientProfileScreen({Key? key, this.client}) : super(key: key);

  @override
  State<UpdateClientProfileScreen> createState() =>
      _UpdateClientProfileScreenState();
}

class _UpdateClientProfileScreenState extends State<UpdateClientProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client!.name),
      ),
    );
  }
}
