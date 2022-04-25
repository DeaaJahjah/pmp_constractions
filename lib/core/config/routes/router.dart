import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/login_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/signup_screen.dart';
import 'package:pmpconstractions/features/settings/settings_screen.dart';
import 'package:pmpconstractions/features/splash_screen/splash_screen.dart';

import '../../featuers/auth/screens/choosing_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case SettingsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SettingsScreen());
    case LogInScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LogInScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case ChoosingScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ChoosingScreen());
  }
  // assert(false, 'Need to implement ${settings.name}');
  return null;
}
