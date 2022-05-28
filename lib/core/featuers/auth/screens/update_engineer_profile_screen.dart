import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';

class UpdateEngineerProfileScreen extends StatefulWidget {
  Engineer? engineer;
  UpdateEngineerProfileScreen({Key? key, this.engineer}) : super(key: key);

  @override
  State<UpdateEngineerProfileScreen> createState() =>
      _UpdateEngineerProfileScreenState();
}

class _UpdateEngineerProfileScreenState
    extends State<UpdateEngineerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(title: Text('Update your data'),));
  }
}
