import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../features/home_screen/services/project_db_service.dart';

class ClientProfile extends StatefulWidget {
  static const routeName = '/';
  String? clientId;
  ClientProfile({Key? key, this.clientId}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  var pref = SharedPreferences.getInstance();
  String? id;
  bool loading = true;
  @override
  void initState() {
    pref.then((value) {
      setState(() {
        id = value.getString('uid');
      });
    });
    super.initState();
  }

  List<String> ids = ['21sFqVCd5qwcwtYWTO02', '21sFqVCd5qwcwtYWTO02'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: FutureBuilder<Client>(
              future: ClientDbService()
                  .getClientById('JDwHY9J7SSfuHWfNgtfFUe1AxN13'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {}
                if (snapshot.hasData) {
                  var client = snapshot.data!;
                  //ids=client.projectsIDs;
                  // print(ids!.length);
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
                        Positioned(
                          top: 20,
                          left: 135,
                          child: Text(
                            context.loc.my_profile,
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
                            backgroundColor: darkBlue,
                            radius: 72,
                            child: CircleAvatar(
                                backgroundColor: orange,
                                radius: 70,
                                child: (client.profilePicUrl != '')
                                    ? CircleAvatar(
                                        backgroundColor: darkBlue,
                                        radius: 68,
                                        backgroundImage: NetworkImage(
                                            client.profilePicUrl ?? ''),
                                      )
                                    : const CircleAvatar(
                                        backgroundColor: darkBlue,
                                        radius: 68,
                                        backgroundImage: AssetImage(
                                            'assets/images/prof.png'),
                                      )),
                          ),
                        ),
                      ]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          client.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        sizedBoxLarge,
                        ElevatedButtonCustom(
                          text: context.loc.contact_info,
                          onPressed: () {},
                          bgColor: beg,
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: beg,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: client.phoneNumbers!
                                  .map((e) => InkWell(
                                        onTap: () async {
                                          await launch('tel:$e');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.call,
                                                color: orange, size: 25),
                                            SizedBox(width: 8),
                                            Text(e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomeRow(
                              icon: Icons.portrait,
                              text: context.loc.my_projects),
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: beg,
                        ),
                        sizedBoxLarge,

                        // Text(
                        //  context.loc.no_projects,
                        //   style: Theme.of(context).textTheme.headlineSmall,
                        // )
                      ],
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
        ),

        SliverFillRemaining(
          child: FutureBuilder<List<Project>>(
            future: ProjectDbService().getPublicProjects(ids),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('has data');
                List<Project> projects = snapshot.data!;
                print(projects.length);
                return Container(
                  width: 200,
                  height: 400,
                  child: BuildProjects(projects: projects));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                height: 100,
                width: 100,
                color: Colors.amber,
              );
            },
          ),
        )
      ],
    ));
  }
}
