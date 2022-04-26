import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: orange,
                  ),
                  fillColor: const Color.fromARGB(47, 11, 29, 55),
                  filled: true,
                  contentPadding: const EdgeInsets.all(2),
                  hintText: 'Search',
                  hintStyle: Theme.of(context).textTheme.headlineSmall,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
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
                          onTap: () {
                            setState(() {
                              changeItemState(0);
                            });
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
