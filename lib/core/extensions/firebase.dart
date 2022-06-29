import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

extension StreamChatContext on BuildContext {
  /// get user id
  String? get userUid => FirebaseAuth.instance.currentUser!.uid;

  /// get the current user
  User? get logedInUser => FirebaseAuth.instance.currentUser;
}
