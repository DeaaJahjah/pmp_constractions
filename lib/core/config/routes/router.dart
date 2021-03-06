import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/featuers/auth/screens/login_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/set_up_company_profile.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/set_up_engineer_profile.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/setup_client_profile.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/signup_screen.dart';
import 'package:pmpconstractions/core/featuers/notification/notification_screen.dart';
import 'package:pmpconstractions/core/featuers/settings/settings_screen.dart';

import 'package:pmpconstractions/features/home_screen/screens/project_details_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/home.dart';
import 'package:pmpconstractions/features/profile/screens/client_profile.dart';
import 'package:pmpconstractions/features/profile/screens/company_profile.dart';
import 'package:pmpconstractions/features/profile/screens/create_project.dart';
import 'package:pmpconstractions/features/profile/screens/engineer_profile.dart';

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
    case SetUpCompanyProfile.routeName:
      return MaterialPageRoute(builder: (_) => const SetUpCompanyProfile());
    case SetUpClientProfile.routeName:
      return MaterialPageRoute(builder: (_) => const SetUpClientProfile());
    case SetUpEngineerProfile.routeName:
      return MaterialPageRoute(builder: (_) => const SetUpEngineerProfile());
    case CompanyProfile.routeName:
      return MaterialPageRoute(builder: (_) => CompanyProfile());
    case EngineerProfile.routeName:
      return MaterialPageRoute(builder: (_) => const EngineerProfile());
    case ClientProfile.routeName:
      return MaterialPageRoute(builder: (_) => ClientProfile());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case ProjectDetailsScreen.routeName:
      return MaterialPageRoute(builder: (_) => ProjectDetailsScreen());

    case NotificationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const NotificationScreen());
    case CreateProject.routeName:
      return MaterialPageRoute(builder: (_) => CreateProject());
  }

  return null;
}
  // assert(false, 'Need to implement ${settings.name}');



