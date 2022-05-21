import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:provider/provider.dart';

class CompanyDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
    Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;

    return Company.fromJson(cc);
  }

  addCompany(Company company, context) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      _db.collection('companies').doc(user!.uid).set(company.toJson());
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
