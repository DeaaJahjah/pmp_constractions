import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button.dart';

class CompanyProfile extends StatefulWidget {
  static const routeName = '/company_profile';
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: orange,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 30,
          color: beg,
        ),
      ),
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
              'Semi Colon',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '''we care about all mobile application project
          programming and design''',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            sizedBoxMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonCustom(
                  text: 'About',
                  onPressed: () {},
                  color: beg,
                  bgColor: beg,
                ),
                ElevatedButtonCustom(
                  text: 'Contact info',
                  onPressed: () {},
                  color: beg,
                  bgColor: darkBlue,
                )
              ],
            ),
            const Divider(
              thickness: 0.5,
              color: beg,
            ),
            sizedBoxSmall,
            CustomeRow(icon: Icons.location_on_outlined, text: 'Location'),
            const Divider(
              thickness: 0.5,
              color: beg,
            ),
            Container(
              width: 320,
              height: 145,
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.fill,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: beg)),
            ),
            sizedBoxSmall,
            CustomeRow(icon: Icons.portrait, text: 'My project'),
            const Divider(
              thickness: 0.5,
              color: beg,
            ),
            sizedBoxMedium,
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
