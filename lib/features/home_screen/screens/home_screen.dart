import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/custom_item.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/search_text_field.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> itemsState = [false, true, false, false];
  changeItemState(int index) {
    if (itemsState[index] == false) {
      itemsState[index] = true;
      for (int i = 0; i < itemsState.length; i++) {
        if (index != i) {
          itemsState[i] = false;
        }
      }
    }
  }

  List<Project> projects = [];
  List<Project> searchedProjects = [];
  bool loading = true;
  TextEditingController textController = TextEditingController();

  Future getProject() async {
    projects = await ProjectDbService().getProjects();
    return projects;
  }

  @override
  void initState() {
    getProject().then((value) => setState(() {
          loading = false;
          searchedProjects = projects;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ref = FirebaseFirestore.instance.collection('projects');
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications, color: darkBlue),
          )
        ],
        leading: const Icon(Icons.menu, color: darkBlue),
        backgroundColor: orange,
        elevation: 0.0,
        title: SizedBox(
            height: 30,
            child: SearchTextField(
                onChanged: onSearchProjects, controller: textController)),
      ),
      body: Column(
        children: [
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              color: orange,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomItem(
                      text: 'ALL',
                      selected: itemsState[0],
                      onTap: () async {
                        setState(() {
                          changeItemState(0);
                        });

                        Project project = Project(
                            name: 'm',
                            description: 'description',
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/justatest-63adb.appspot.com/o/bulding1.png?alt=media&token=e832f13a-61b2-4fd0-bee5-082ff0acb388',
                            location: const GeoPoint(30.22, 3),
                            isOpen: true,
                            modelUrl: 'https://dadva',
                            privacy: true,
                            members: const [
                              MemberRole(
                                  memberId: 'dadad_id',
                                  memberName: 'memberName',
                                  profilePicUrl: 'profilePicUrl',
                                  role: Role.projectEngineer),
                              MemberRole(
                                  memberId: 'dadad_id',
                                  memberName: 'memberName',
                                  profilePicUrl: 'profilePicUrl',
                                  role: Role.projectEngineer)
                            ]);
                        ref.add(project.toJson());
                      }),
                  CustomItem(
                      text: 'project',
                      icon: Icons.business,
                      selected: itemsState[1],
                      onTap: () {
                        setState(() {
                          changeItemState(1);
                        });
                      }),
                  CustomItem(
                      text: 'Companies',
                      icon: Icons.business,
                      selected: itemsState[2],
                      onTap: () {
                        setState(() {
                          changeItemState(2);
                        });
                      }),
                  CustomItem(
                      text: 'Enginerrs',
                      icon: Icons.business,
                      selected: itemsState[3],
                      onTap: () {
                        setState(() {
                          changeItemState(3);
                        });
                      })
                ],
              ),
            ),
          ]),
          Expanded(
              child: (loading)
                  ? const Center(child: CircularProgressIndicator())
                  : BuildProjects(
                      projects: searchedProjects,
                    ))
        ],
      ),
    );
  }

  void onSearchProjects(String value) {
    if (textController.text.isEmpty) {
      setState(() {
        searchedProjects = projects;
      });

      return;
    }
    final suggestion = projects.where((project) {
      final projectName = project.name.toLowerCase();
      final searchTitle = value.toLowerCase();
      return projectName.contains(searchTitle);
    }).toList();
    setState(() {
      searchedProjects = suggestion;
    });
  }
}
