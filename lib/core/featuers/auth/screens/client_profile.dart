import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button.dart';

class ClientProfile extends StatefulWidget {
  static const routeName = '/client_profile';
  const ClientProfile({Key? key}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(
          height: 225,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: const BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
            ),
            Positioned(
                top: 15,
                left: 7,
                child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: darkBlue,
                    ),
                    onPressed: () {})),
            const Positioned(
              top: 20,
              left: 135,
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
              top: 78,
              left: 107,
              child: CircleAvatar(
                  backgroundColor: orange,
                  radius: 70,
                  child: CircleAvatar(
                    backgroundColor: darkBlue,
                    radius: 68,
                  )),
            ),
          ]),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Deaa Jahjah',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            sizedBoxLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButtonCustom(
                  text: 'Contact info',
                  onPressed: () {},
                  color: beg,
                  bgColor: beg,
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
              color: beg,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 140,
            ),
            CustomeRow(icon: Icons.portrait, text: 'My project'),
            const Divider(
              thickness: 0.5,
              color: beg,
            ),
            sizedBoxLarge,
            Text(
              'No projects Yet',
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ],
        )
      ]),
    );
  }
}
