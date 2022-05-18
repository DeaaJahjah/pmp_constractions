import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/set_up_company_profile.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/set_up_engineer_profile.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/setup_client_profile.dart';
import 'package:pmpconstractions/core/widgets/radio_button_custom.dart';

class ChoosingScreen extends StatefulWidget {
  static const routeName = '/';

  const ChoosingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChoosingScreen> createState() => _ChoosingScreenState();
}

class _ChoosingScreenState extends State<ChoosingScreen> {
  int index = 0;
  int value = 0;
  UserType? userType;

  @override
  Widget build(BuildContext context) {
    print('value =$value');
    print('index =$index');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose one'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(children: [
        Image.asset(
          'assets/images/chose_one.png',
          fit: BoxFit.fill,
        ),
        sizedBoxXLarge,
        Column(
          children: <Widget>[
            CustomeRadioButton(
                text: 'Company',
                value: value,
                index: 1,
                onPressed: () {
                  setState(() {
                    value = 1;
                    userType = UserType.company;
                  });
                }),
            sizedBoxMedium,
            CustomeRadioButton(
                text: 'Engineer',
                value: value,
                index: 2,
                onPressed: () {
                  setState(() {
                    value = 2;
                    userType = UserType.engineer;
                  });
                }),
            sizedBoxMedium,
            CustomeRadioButton(
                text: 'Client',
                value: value,
                index: 3,
                onPressed: () {
                  setState(() {
                    value = 3;
                    userType = UserType.client;
                  });
                }),
          ],
        ),
        sizedBoxLarge,
        ElevatedButton(
          onPressed: () {
            switch (userType) {
              case UserType.engineer:
                Navigator.of(context).pushNamed(SetUpEngineerProfile.routeName);
                break;
              case UserType.company:
                Navigator.of(context).pushNamed(SetUpCompanyProfile.routeName);
                break;
              case UserType.client:
                Navigator.of(context).pushNamed(SetUpClientProfile.routeName);
                break;
              default:
                print('cant');
            }
          },
          child: Text(
            'NEXT',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        )
      ]),
    );
  }
}
