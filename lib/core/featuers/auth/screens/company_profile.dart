import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class CompanyProfile extends StatefulWidget {
  static const routeName = '/';
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            color: orange,
          ),
          const Positioned(
            top: 20,
            left: 140,
            child: Text(
              'My profile',
              style: TextStyle(
                  color: darkBlue,
                  fontFamily: font,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            child: SizedBox(
              width: 170,
              height: 170,
              child: CircleAvatar(
                backgroundColor: orange,
              ),
            ),
            top: 90,
            left: 100,
          ),
          const Positioned(
            child: SizedBox(
              width: 160,
              height: 160,
              child: CircleAvatar(
                backgroundColor: darkBlue,
              ),
            ),
            top: 95,
            left: 105,
          ),
        ])
      ]),
    );
  }
}
