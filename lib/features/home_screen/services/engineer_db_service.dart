import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/home.dart';
import 'package:provider/provider.dart';

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
    try {
      var doc = await _db.collection('engineers').doc(id).get();

      Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;
      return Engineer.fromJson(cc);
    } on FirebaseException {
      return Engineer(name: 'name', specialization: '', experience: const {});
    }
  }

  addEngineer(Engineer engineer, context) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      _db.collection('engineers').doc(user!.uid).set(engineer.toJson());

      await Provider.of<DataProvider>(context, listen: false).fetchData();

      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      NotificationDbService().addNotification(NotificationModle(
        title: 'Welcome',
        body: 'hi ${engineer.name} have a great time',
        category: 'new',
        imageUrl: engineer.profilePicUrl!,
        isReaded: false,
        pauload: '/notification',
      ));

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
