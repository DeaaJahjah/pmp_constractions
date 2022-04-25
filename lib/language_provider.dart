import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale locale = const Locale('en');

  changeLanguge(Locale newLanguage) {
    locale = (newLanguage.languageCode == 'en')
        ? const Locale('en')
        : const Locale('ar');
    notifyListeners();
  }
}
