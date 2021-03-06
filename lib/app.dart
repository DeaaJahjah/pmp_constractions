import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/routes/router.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/services/authentication_service.dart';
import 'package:pmpconstractions/core/featuers/notification/providers/notification_provider.dart';
import 'package:pmpconstractions/core/featuers/notification/services/navigation_service.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/home_screen/providers/comoany_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/engineer_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/project_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/search_category_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/search_provider.dart';
import 'package:pmpconstractions/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: darkTheme,
      builder: (context, currentTheme) => MultiProvider(
        providers: [
          ChangeNotifierProvider<LanguageProvider>(
              create: (context) => LanguageProvider()),
          ChangeNotifierProvider<SearchProvider>(
              create: (context) => SearchProvider()),
          ChangeNotifierProvider<DataProvider>(
              create: (context) => DataProvider()),
          ChangeNotifierProvider<SearchCategoryProvider>(
              create: (context) => SearchCategoryProvider()),
          ChangeNotifierProxyProvider<DataProvider, ProjectProvider>(
            create: (context) => ProjectProvider(null),
            update: (context, dataProvider, projectProvider) =>
                ProjectProvider(dataProvider),
          ),
          ChangeNotifierProxyProvider<DataProvider, CompanyProvider>(
            create: (context) => CompanyProvider(null),
            update: (context, dataProvider, companyProvider) =>
                CompanyProvider(dataProvider),
          ),
          ChangeNotifierProxyProvider<DataProvider, EnginnerProvider>(
            create: (context) => EnginnerProvider(null),
            update: (context, dataProvider, companyProvider) =>
                EnginnerProvider(dataProvider),
          ),
          Provider<FlutterFireAuthService>(
              create: (_) => FlutterFireAuthService(FirebaseAuth.instance)),
          StreamProvider(
            initialData: null,
            create: (context) =>
                context.read<FlutterFireAuthService>().authStateChanges,
          ),
          ChangeNotifierProvider<AuthSataProvider>(
              create: (context) => AuthSataProvider()),
          StreamProvider(
              create: (context) => NotificationDbService().showNotification(),
              lazy: true,
              initialData: null),
          ChangeNotifierProvider<NotificationProvider>(
              create: (context) => NotificationProvider())
        ],
        child: Consumer<LanguageProvider>(
          builder: (context, value, _) => MaterialApp(

            navigatorKey: GlobalVariable.navState,
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            theme: currentTheme,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            onGenerateTitle: (context) => context.loc.localeName,
            onGenerateRoute: onGenerateRoute,
            locale: value.locale,
          ),
        ),
      ),
    );
  }
}
