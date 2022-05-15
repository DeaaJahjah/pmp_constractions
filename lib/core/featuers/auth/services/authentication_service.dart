import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/choosing_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/login_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;
  final pref = SharedPreferences.getInstance();
  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    pref.then((value) => value.remove('uid'));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  Future<String?> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential crid;
    try {
      crid = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed In");

      pref.then((value) => value.setString('uid', crid.user!.uid));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
    return null;
  }

  Future<String?> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var crid = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      pref.then((value) => value.setString('uid', crid.user!.uid));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChoosingScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
    return null;
  }
}