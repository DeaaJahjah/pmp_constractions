import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EngineerDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Engineer>> getEngineers() async {
    var queryData = await _db.collection('engineers').get();
    List<Engineer> engineers = [];

    for (var doc in queryData.docs) {
      engineers.add(Engineer.fromFirestore(doc));
    }

    return engineers;
  }

  Future<Engineer> getEngineerById(String id) async {
    var doc = await _db.collection('engineers').doc(id).get();
    Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;

    return Engineer.fromJson(cc);
  }

  addEngineer(Engineer engineer, context) async {
    try {
      final pref = await SharedPreferences.getInstance();
      _db
          .collection('engineers')
          .doc(pref.getString('uid'))
          .set(engineer.toJson());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseException catch (e) {
      print(e.toString());
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
