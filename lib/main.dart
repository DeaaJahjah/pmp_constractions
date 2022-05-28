import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/app.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  // setupLocator();
  runApp(const App());
}
