import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/choosing_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/login_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;
  final pref = SharedPreferences.getInstance();
  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    pref.then((value) => value.remove('uid'));
    Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
  }

  Future<String?> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential crid;
    context
        .read<AuthSataProvider>()
        .changeAuthState(newState: AuthState.waiting);

    try {
      crid = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      context
          .read<AuthSataProvider>()
          .changeAuthState(newState: AuthState.notSet);

      pref.then((value) => value.setString('uid', crid.user!.uid));

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

      return "Success";
    } on FirebaseAuthException catch (e) {
      context
          .read<AuthSataProvider>()
          .changeAuthState(newState: AuthState.notSet);
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
    return null;
  }

  Future<String?> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    context
        .read<AuthSataProvider>()
        .changeAuthState(newState: AuthState.waiting);
    try {
      var crid = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      context
          .read<AuthSataProvider>()
          .changeAuthState(newState: AuthState.notSet);
      pref.then((value) => value.setString('uid', crid.user!.uid));
      Navigator.of(context).pushReplacementNamed(ChoosingScreen.routeName);

      return "Success";
    } on FirebaseAuthException catch (e) {
      context
          .read<AuthSataProvider>()
          .changeAuthState(newState: AuthState.notSet);
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
    return null;
  }
}
