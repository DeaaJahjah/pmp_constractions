import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/routes/router.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/download_state_provider.dart';

import 'package:pmpconstractions/core/featuers/notification/services/navigation_service.dart';
import 'package:pmpconstractions/features/home_screen/providers/comoany_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/engineer_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/project_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/search_category_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/search_provider.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
          ChangeNotifierProvider<AuthSataProvider>(
              create: (context) => AuthSataProvider()),
          ChangeNotifierProvider<SelectedProjectProvider>(
              create: (context) => SelectedProjectProvider(null)),
          // StreamProvider<ConnectivityStatus>(
          //   create: (context) =>
          //       ConnectivityService().connectionStatusController.stream,
          //   initialData: ConnectivityStatus.offline,

          // )
          ChangeNotifierProvider<DownloadStateProvider>(
            create: (context) => DownloadStateProvider(),
          )
        ],
        child: Consumer<LanguageProvider>(
          builder: (context, value, _) => ThemeProvider(
              initTheme: darkTheme,
              builder: (context, currentTheme) => MaterialApp(
                    navigatorKey: GlobalVariable.navState,
                    debugShowCheckedModeBanner: false,
                    theme: currentTheme,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    onGenerateTitle: (context) => context.loc.localeName,
                    onGenerateRoute: onGenerateRoute,
                    locale: value.locale,
                  )),
        ));
  }
}
