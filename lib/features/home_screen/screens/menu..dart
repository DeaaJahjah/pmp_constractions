import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';

import 'package:pmpconstractions/core/featuers/auth/services/authentication_service.dart';
import 'package:pmpconstractions/core/featuers/settings/settings_screen.dart';

import 'package:pmpconstractions/features/home_screen/providers/comoany_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/engineer_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/menu_row.dart';
import 'package:pmpconstractions/features/profile/screens/client_profile.dart';
import 'package:pmpconstractions/features/profile/screens/company_profile.dart';
import 'package:pmpconstractions/features/profile/screens/engineer_profile.dart';
import 'package:provider/provider.dart';
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
    switch (user?.displayName) {
      case 'engineer':
        if (Provider.of<EnginnerProvider>(context, listen: true)
            .engineers
            .isNotEmpty) {
          var engineer = Provider.of<EnginnerProvider>(context, listen: true)
              .engineers
              .firstWhere((element) => element.userId == user!.uid);
          imgUrl = engineer.profilePicUrl;
          name = engineer.name;
        }
        break;
      case 'company':
        if (Provider.of<CompanyProvider>(context, listen: true)
            .companies
            .isNotEmpty) {
          var company = Provider.of<CompanyProvider>(context, listen: true)
              .companies
              .firstWhere((element) => element.userId == user!.uid);
          imgUrl = company.profilePicUrl;
          name = company.name;
        }

        break;
      case 'client':
        if (Provider.of<DataProvider>(context, listen: true)
            .clients
            .isNotEmpty) {
          var client = Provider.of<DataProvider>(context, listen: true)
              .clients
              .firstWhere((element) => element.userId == user!.uid);
          imgUrl = client.profilePicUrl;
          name = client.name;
        }

        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () async {
                print(user!.displayName);
                switch (user.displayName) {
                  case 'engineer':
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EngineerProfile(
                              engineerId: user.uid,
                            )));
                    break;
                  case 'company':
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CompanyProfile(
                              companyId: user.uid,
                            )));
                    break;
                  case 'client':
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ClientProfile(
                              clientId: user.uid,
                            )));
                    break;
                }
              },
              child: (imgUrl != null)
                  ? CircleAvatar(
                      backgroundColor: orange,
                      radius: 40,
                      child: CashedImage(
                        imageUrl: imgUrl,
                        radius: 40,
                        size: 100,
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: orange,
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/prof.png'),
                    )),
          sizedBoxSmall,
          Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          sizedBoxLarge,
          InkWell(
            onTap: () {
              widget.panelController!.open();
            },
            child: MenuRow(
              icon: Icons.home,
              text: context.loc.projects,
            ),
          ),
          sizedBoxMedium,
          InkWell(
            onTap: (() =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName)),
            child: MenuRow(
              icon: Icons.settings,
              text: context.loc.settings,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.47,
          ),
          InkWell(
              onTap: () {
                Provider.of<FlutterFireAuthService>(context, listen: false)
                    .signOut(context);
              },
              child: MenuRow(icon: Icons.logout, text: context.loc.log_out))
        ],
      ),
    );
  }
}
