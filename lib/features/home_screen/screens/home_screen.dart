import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/custom_item.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/project_widget.dart';
import 'package:pmpconstractions/features/home_screen/services/db.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> itemsState = [true, false, false, false];
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

  @override
  Widget build(BuildContext context) {
    var ref = FirebaseFirestore.instance.collection('projects');
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.notifications, color: darkBlue),
            )
          ],
          leading: const Icon(Icons.menu, color: darkBlue),
          backgroundColor: orange,
          elevation: 0.0,
          // centerTitle: true,
          title: SizedBox(
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  fillColor: Color.fromARGB(15, 11, 29, 55),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Search',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          floating: true,
          pinned: true,
          snap: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
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
                                name: 'Jahjah',
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
              ])
            ],
          ),
        ),
        SliverFillRemaining(
            child: FutureBuilder<List<Project>>(
                future: ProjectDbService().getProjects(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Project> projects = snapshot.data!;

                    return MasonryGridView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),

                        // vertical gap between two items
                        mainAxisSpacing: 40,
                        // horizontal gap between two items
                        crossAxisSpacing: 10,
                        itemCount: projects.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return ProjectWidget(
                            name: projects[index].name,
                            projectId: projects[index].projectId.toString(),
                            imageUrl: projects[index].imageUrl,
                            index: index,
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Text('error');
                }))
      ],
    ));
  }
}
