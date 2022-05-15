import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button.dart';

class EngineerProfile extends StatefulWidget {
  const EngineerProfile({Key? key}) : super(key: key);
  static const routeName = '/engineer_profile';
  @override
  State<EngineerProfile> createState() => _EngineerProfileState();
}

class _EngineerProfileState extends State<EngineerProfile> {
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
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Sawsan Ahmad',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Architectural engineer',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          sizedBoxSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButtonCustom(
                text: 'Experiences',
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
        ]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomeRow(
                icon: Icons.language, text: 'Languages', editIcon: Icons.edit),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '''English
Arabic''',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            CustomeRow(
                icon: Icons.filter_frames_sharp,
                text: 'Certificates',
                editIcon: Icons.edit),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '''Certificate in Architecture''',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            CustomeRow(
                icon: Icons.computer, text: 'Programs', editIcon: Icons.edit),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '''3D Max
Autocad''',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            CustomeRow(icon: Icons.portrait, text: 'My project'),
            const Divider(
              thickness: 0.5,
              color: beg,
            ),
            sizedBoxLarge,
          ],
        ),
        Text(
          'No projects Yet',
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ]),
    );
  }
}
