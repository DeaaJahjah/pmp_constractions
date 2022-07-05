import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:pmpconstractions/features/profile/screens/update_client_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../features/home_screen/services/project_db_service.dart';

class ClientProfile extends StatefulWidget {
  static const routeName = '/client_profile';
  String? clientId;
  ClientProfile({Key? key, this.clientId}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  late Client client;

  bool loading = true;
  ScrollController scrollController = ScrollController();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void didChangeDependencies() {
    loading = true;
    ClientDbService().getClientById(widget.clientId!).then((data) {
      print(data.phoneNumbers!.length);
      ids = data.projectsIDs;
      client = data;
      setState(() {
        loading = false;
      });
    });

    super.didChangeDependencies();
  }

  List<String>? ids;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            (loading == false)
                ? SliverList(
                    delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 300,
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
                          top: 20,
                          left: 135,
                          child: Text(
                            context.loc.my_profile,
                            style: const TextStyle(
                                color: darkBlue,
                                fontFamily: font,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          top: 78,
                          left: (MediaQuery.of(context).size.width / 2) - 72,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: darkBlue,
                                radius: 72,
                                child: CircleAvatar(
                                    backgroundColor: orange,
                                    radius: 70,
                                    child: (client.profilePicUrl != '')
                                        ? CircleAvatar(
                                            backgroundColor: darkBlue,
                                            radius: 68,
                                            child: CashedImage(
                                                radius: 68,
                                                size: 150,
                                                imageUrl:
                                                    client.profilePicUrl!))
                                        : const CircleAvatar(
                                            backgroundColor: darkBlue,
                                            radius: 68,
                                            backgroundImage: AssetImage(
                                                'assets/images/prof.png'),
                                          )),
                              ),
                              Text(
                                client.name,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              sizedBoxMedium
                            ],
                          ),
                        ),
                      ]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButtonCustom(
                                text: context.loc.contact_info,
                                onPressed: () {},
                                bgColor: beg,
                              ),
                            ),
                          ],
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
                                            const Icon(Icons.call,
                                                color: orange, size: 25),
                                            const SizedBox(width: 8),
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
                      ],
                    )
                  ]))
                : const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
            (!loading)
                ? SliverFillRemaining(
                    child: FutureBuilder<List<Project>>(
                      future: ProjectDbService().getPublicProjects(ids!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Project> projects = snapshot.data!;
                          if (projects.isEmpty) {
                            return const Center(
                              child: Text('no open project'),
                            );
                          }

                          return BuildProjects(
                            projects: projects,
                            scrollController: scrollController,
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Container(
                          height: 100,
                          width: 100,
                          color: Colors.amber,
                        );
                      },
                    ),
                  )
                : const SliverToBoxAdapter(
                    child: SizedBox(),
                  )
          ],
        ),
        floatingActionButton: (uid == widget.clientId)
            ? FloatingActionButton(
                backgroundColor: orange,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => UpdateClientProfileScreen(
                                client: client,
                              )))
                      .then((value) async {
                    setState(() {});
                  });
                },
                child: const Icon(
                  Icons.edit,
                  color: white,
                ),
              )
            : const SizedBox());
  }
}
