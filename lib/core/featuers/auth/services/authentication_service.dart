import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/choosing_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/login_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/home.dart';
import 'package:provider/provider.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;
  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    context
        .read<AuthSataProvider>()
        .changeAuthState(newState: AuthState.waiting);

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      context
          .read<AuthSataProvider>()
          .changeAuthState(newState: AuthState.notSet);

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      context
          .read<AuthSataProvider>()
          .changeAuthState(newState: AuthState.notSet);
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
  }

  Future<String?> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    context
        .read<AuthSataProvider>()
        .changeAuthState(newState: AuthState.waiting);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      context
          .read<AuthSataProvider>()
          .changeAuthState(newState: AuthState.notSet);

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
