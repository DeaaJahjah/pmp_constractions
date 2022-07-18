import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';

import 'package:pmpconstractions/core/featuers/auth/services/authentication_service.dart';
import 'package:pmpconstractions/core/featuers/settings/settings_screen.dart';

import 'package:pmpconstractions/features/home_screen/screens/widgets/menu_row.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/profile_image_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MenuScreen extends StatefulWidget {
  PanelController? panelController;
  MenuScreen({Key? key, this.panelController}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    String? imgUrl;
    String name = '';
    // switch (user?.displayName) {
    //   case 'engineer':
    //     if (Provider.of<EnginnerProvider>(context, listen: true)
    //         .engineers
    //         .isNotEmpty) {
    //       var engineer = Provider.of<EnginnerProvider>(context, listen: true)
    //           .engineers
    //           .firstWhere((element) => element.userId == user!.uid);
    //       imgUrl = engineer.profilePicUrl;
    //       name = engineer.name;
    //     }
    //     break;
    //   case 'company':
    //     if (Provider.of<CompanyProvider>(context, listen: true)
    //         .companies
    //         .isNotEmpty) {
    //       var company = Provider.of<CompanyProvider>(context, listen: true)
    //           .companies
    //           .firstWhere((element) => element.userId == user!.uid);
    //       imgUrl = company.profilePicUrl;
    //       name = company.name;
    //     }

    //     break;
    //   case 'client':
    //     if (Provider.of<DataProvider>(context, listen: true)
    //         .clients
    //         .isNotEmpty) {
    //       var client = Provider.of<DataProvider>(context, listen: true)
    //           .clients
    //           .firstWhere((element) => element.userId == user!.uid);
    //       imgUrl = client.profilePicUrl;
    //       name = client.name;
    //     }

    //     break;
    // }

    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileImageMenu(),
          sizedBoxSmall,
          Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          sizedBoxLarge,
          MenuRow(
            onTap: () {
              widget.panelController!.open();
            },
            icon: Icons.home,
            text: context.loc.projects,
          ),
          sizedBoxMedium,
          MenuRow(
            icon: Icons.settings,
            text: context.loc.settings,
            onTap: (() =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.47,
          ),
          MenuRow(
            icon: Icons.logout,
            text: context.loc.log_out,
            onTap: () async {
              await FlutterFireAuthService().signOut(context);
            },
          )
        ],
      ),
    );
  }
}
