import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:pmpconstractions/features/project/models/project.dart';
import 'package:pmpconstractions/features/project/services/project_db_service.dart';
import 'package:pmpconstractions/features/profile/screens/update_engineer_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';

class EngineerProfile extends StatefulWidget {
  final String? engineerId;

  const EngineerProfile({Key? key, this.engineerId}) : super(key: key);
  static const routeName = '/engineer_profile';
  @override
  State<EngineerProfile> createState() => _EngineerProfileState();
}

class _EngineerProfileState extends State<EngineerProfile> {
  bool elevatedButtonCase = true;

  Engineer? engineer;
  ScrollController scrollController = ScrollController();

  bool loading = true;
  @override
  void initState() {
    EngineerDbService().getEngineerById(widget.engineerId!).then((value) {
      engineer = value;
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    print(widget.engineerId);
    print(uid);
    return Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            (!loading)
                ? SliverList(
                    delegate: SliverChildListDelegate([
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
                                    child: (engineer!.profilePicUrl != '')
                                        ? CircleAvatar(
                                            backgroundColor: darkBlue,
                                            radius: 68,
                                            child: CashedImage(
                                                radius: 68,
                                                size: 150,
                                                imageUrl:
                                                    engineer!.profilePicUrl ??
                                                        ''))
                                        : const CircleAvatar(
                                            backgroundColor: darkBlue,
                                            radius: 68,
                                            backgroundImage: AssetImage(
                                                'assets/images/engineer_orange.png')),
                                  ),
                                ),
                                Text(
                                  engineer!.name,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  engineer!.specialization,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                sizedBoxSmall,
                              ],
                            ),
                          )
                        ]),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              engineer!.name,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              engineer!.specialization,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            sizedBoxSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButtonCustom(
                                  text: context.loc.experience,
                                  onPressed: () {
                                    elevatedButtonCase = true;
                                    setState(() {});
                                  },
                                  bgColor: (elevatedButtonCase == true)
                                      ? beg
                                      : darkBlue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButtonCustom(
                                  text: context.loc.contact_info,
                                  onPressed: () {
                                    elevatedButtonCase = false;
                                    setState(() {});
                                  },
                                  bgColor: (elevatedButtonCase == true)
                                      ? darkBlue
                                      : beg,
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: beg,
                            ),
                          ]),
                      (elevatedButtonCase == true)
                          ? Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomeRow(
                                      icon: Icons.language,
                                      text: context.loc.languages,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: engineer!
                                              .experience!['languages']!
                                              .map((e) => Text(e,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall))
                                              .toList(),
                                        )),
                                    CustomeRow(
                                      icon: Icons.filter_frames_sharp,
                                      text: context.loc.certificate,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: engineer!
                                              .experience!['certificates']!
                                              .map((e) => Text(e,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall))
                                              .toList(),
                                        )),
                                    CustomeRow(
                                      icon: Icons.computer,
                                      text: context.loc.programs,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: engineer!
                                              .experience!['programs']!
                                              .map((e) => Text(e,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall))
                                              .toList(),
                                        )),
                                  ]),
                            )
                          : SizedBox(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: engineer!.phoneNumbers!
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
                      CustomeRow(
                          icon: Icons.portrait, text: context.loc.my_projects),
                      const Divider(
                        thickness: 0.5,
                        color: beg,
                      ),
                      sizedBoxLarge,
                    ]),
                  )
                : const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
            (!loading)
                ? SliverFillRemaining(
                    child: FutureBuilder<List<Project>>(
                      future: ProjectDbService()
                          .getPublicProjects(engineer!.projectsIDs),
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
                        return const SizedBox();
                      },
                    ),
                  )
                : const SliverToBoxAdapter(
                    child: SizedBox(),
                  )
          ],
        ),
        floatingActionButton: (uid == widget.engineerId)
            ? FloatingActionButton(
                backgroundColor: orange,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateEngineerProfileScreen(
                            engineer: engineer!,
                          )));
                },
                child: const Icon(
                  Icons.edit,
                  color: white,
                ),
              )
            : const SizedBox());
  }
}
