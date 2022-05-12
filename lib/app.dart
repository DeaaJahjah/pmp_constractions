import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/routes/router.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
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
        ],
        child: Consumer<LanguageProvider>(
          builder: (context, value, _) => MaterialApp(
            initialRoute: '/engineer_profile',
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
