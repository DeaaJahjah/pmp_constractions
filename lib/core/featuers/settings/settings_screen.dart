import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/widgets/custom_appbar.dart';
import 'package:pmpconstractions/language_provider.dart';

import 'package:provider/provider.dart';
import 'custome_row.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? currentLanguage = 'en';
  bool isSwitched = true;
  final List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(
      child: Text('EN'),
      value: 'en',
    ),
    const DropdownMenuItem(
      child: Text('AR'),
      value: 'ar',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: customeAppBar(
            title: context.loc.settings,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(children: [
                CustomeRow(
                  icon: Icons.color_lens,
                  text: context.loc.theme,
                ),
                const SizedBox(width: 160),
                ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return FlutterSwitch(
                          value: isSwitched,
                          height: 30,
                          width: 50,
                          toggleSize: 20,
                          borderRadius: 50,
                          activeColor: darkBlue,
                          inactiveColor: white,
                          toggleColor: orange,
                          switchBorder: Border.all(
                            color: orange,
                          ),
                          inactiveIcon: const Icon(
                            Icons.light_mode,
                            color: white,
                          ),
                          activeIcon: const Icon(
                            Icons.dark_mode,
                            color: darkBlue,
                          ),
                          onToggle: (value) {
                            isSwitched = !isSwitched;
                            ThemeSwitcher.of(context).changeTheme(
                              theme: ThemeModelInheritedNotifier.of(context)
                                          .theme
                                          .brightness ==
                                      Brightness.light
                                  ? darkTheme
                                  : lightTheme,
                            );
                          });
                    }),
              ]),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: CustomeRow(
                          icon: Icons.language, text: context.loc.language)),
                  const SizedBox(width: 120),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                        style: const TextStyle(color: orange),
                        iconEnabledColor: orange,
                        focusColor: orange,
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none),
                        dropdownColor: beg,
                        items: items,
                        value: currentLanguage,
                        onChanged: (selectedLanguage) {
                          setState(() {
                            currentLanguage = selectedLanguage;
                            Provider.of<LanguageProvider>(context,
                                    listen: false)
                                .changeLanguge(Locale(
                                    selectedLanguage == 'en' ? 'en' : 'ar'));
                          });
                        }),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: const [
                    Positioned(
                      child: Image(
                        image:
                            AssetImage('assets/images/setting_buillding.png'),
                      ),
                      bottom: 0,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
