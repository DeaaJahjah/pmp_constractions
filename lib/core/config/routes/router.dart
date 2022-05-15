import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/login_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/signup_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/home_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/project_details_screen.dart';
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
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case ProjectDetailsScreen.routeName:
      return MaterialPageRoute(builder: (_) => ProjectDetailsScreen());
  }
  return null;
}
  // assert(false, 'Need to implement ${settings.name}');



