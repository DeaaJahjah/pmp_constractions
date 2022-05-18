import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/screens/menu_row.dart';
import 'package:pmpconstractions/features/settings/settings_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {},
              child: const CircleAvatar(backgroundColor: orange, radius: 40)),
          sizedBoxSmall,
          Text(
            'sawsan Ahmad',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          sizedBoxLarge,
          InkWell(
            onTap: () {},
            child: const MenuRow(
              icon: Icons.home,
              text: 'Project',
            ),
          ),
          sizedBoxMedium,
          InkWell(
            onTap: (() =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName)),
            child: const MenuRow(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.47,
          ),
          const MenuRow(icon: Icons.logout, text: 'Logout')
        ],
      ),
    );
  }
}
