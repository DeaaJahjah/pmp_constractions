import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/home.dart';
import 'package:provider/provider.dart';

class CompanyDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  Future<List<Company>> getCompanies() async {
    var queryData = await _db.collection('companies').get();
    List<Company> companies = [];

    for (var doc in queryData.docs) {
      companies.add(Company.fromFirestore(doc));
    }

    return companies;
  }

  Future<Company> getCompanyById(String id) async {
    var doc = await _db.collection('companies').doc(id).get();

    return Company.fromFirestore(doc);
  }

  addCompany(Company company, context) async {
    try {
      _db.collection('companies').doc(user!.uid).set(company.toJson());

      await Provider.of<DataProvider>(context, listen: false).fetchData();

      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      NotificationDbService().addNotification(NotificationModle(
        title: 'Welcome',
        body: 'hi ${company.name} have a great time',
        type: NotificationType.none,
        imageUrl: imageUrl,
        isReaded: false,
        pauload: '/notification',
      ));

      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  updateCompany(Company company, context) async {
    try {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.waiting);

      await _db.collection('companies').doc(user!.uid).update(company.toJson());
      await Provider.of<DataProvider>(context, listen: false).fetchData();

      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      const snackBar = SnackBar(content: Text('Sucess MSG'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      final snackBar = SnackBar(
          backgroundColor: Colors.red[500], content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
