import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EngineerProfile extends StatefulWidget {
  final String? engineerId;
  const EngineerProfile({Key? key, this.engineerId}) : super(key: key);
  static const routeName = '/profile_engineer';
  @override
  State<EngineerProfile> createState() => _EngineerProfileState();
}

class _EngineerProfileState extends State<EngineerProfile> {
  var pref = SharedPreferences.getInstance();
  String? id;
  @override
  void initState() {
    pref.then((value) {
      setState(() {
        id = value.getString('uid');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Engineer>(
          future:
              EngineerDbService().getEngineerById(widget.engineerId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var enginner = snapshot.data!;
              return ListView(children: [
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
                    Positioned(
                      top: 78,
                      left: 107,
                      child: CircleAvatar(
                          backgroundColor: orange,
                          radius: 70,
                          child: CircleAvatar(
                            backgroundColor: darkBlue,
                            radius: 68,
                            backgroundImage:
                                NetworkImage(enginner.profilePicUrl ?? ''),
                          )),
                    ),
                  ]),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    enginner.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    enginner.specialization,
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
                        icon: Icons.language,
                        text: 'Languages',
                        editIcon: (id == enginner.userId) ? Icons.edit : null),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: enginner.experience!['languages']!
                              .map((e) => Text(e,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall))
                              .toList(),
                        )),
                    CustomeRow(
                        icon: Icons.filter_frames_sharp,
                        text: 'Certificates',
                        editIcon: (id == enginner.userId) ? Icons.edit : null),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: enginner.experience!['certificates']!
                              .map((e) => Text(e,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall))
                              .toList(),
                        )),
                    CustomeRow(
                        icon: Icons.computer,
                        text: 'Programs',
                        editIcon: (id == enginner.userId) ? Icons.edit : null),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: enginner.experience!['programs']!
                              .map((e) => Text(e,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall))
                              .toList(),
                        )),
                    CustomeRow(
                        icon: Icons.filter_frames_sharp,
                        text: 'Contact info',
                        editIcon: Icons.phone),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: enginner.phoneNumbers!
                              .map((e) => InkWell(
                                    onTap: () async {
                                      await launch('tel:$e');
                                    },
                                    child: Text(e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ))
                              .toList(),
                        )),
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
              ]);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
