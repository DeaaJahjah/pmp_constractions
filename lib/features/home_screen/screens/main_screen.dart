import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/notification/notification_screen.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/home_screen/providers/comoany_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/engineer_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/project_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/search_category_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/search_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_all.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/bulid_companies_card.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/bulid_engineers_card.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/custom_item.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/search_text_field.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  ZoomDrawerController? zoomController;
  MainScreen({Key? key, this.zoomController}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController textController = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context);

    var searchCatProvider =
        Provider.of<SearchCategoryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () async {
                    Navigator.of(context)
                        .pushNamed(NotificationScreen.routeName);
                  },
                  child: StreamBuilder<int>(
                      stream:
                          NotificationDbService().getUnreadedNotifications(),
                      builder: (context, snapshot) {
                        return Stack(children: [
                          const Icon(Icons.notifications, color: darkBlue),
                          if (snapshot.data != 0)
                            Positioned(
                                child: CircleAvatar(
                              backgroundColor: beg,
                              radius: 10,
                              child: Text(snapshot.data.toString()),
                            )),
                        ]);
                      })))
        ],
        leading: InkWell(
            onTap: () {
              if (widget.zoomController != null) {
                widget.zoomController!.toggle!();
              }
            },
            child: const Icon(Icons.menu, color: darkBlue)),
        backgroundColor: orange,
        elevation: 0.0,
        title: SizedBox(
            height: 30,
            child:
                SearchTextField(onChanged: search, controller: textController)),
      ),
      body: Column(
        children: [
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              color: orange,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Consumer<SearchCategoryProvider>(
                  builder: (context, value, child) =>
                      AnimationConfiguration.staggeredList(
                          position: 1,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: ListView.builder(
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) => CustomItem(
                                    searchCategory: value.searchCategories[i],
                                    onTap: () {
                                      searchCatProvider.chnageCategory(i);
                                      searchProvider.searchState(value
                                          .searchCategories[i].searchCategory);
                                      search(textController.text);
                                    }),
                              ))))),
            ),
          ]),
          if (searchProvider.searchType == SearchType.all)
            const Expanded(
              child: BuildAll(),
            )
          else if (searchProvider.searchType == SearchType.project)
            Consumer<ProjectProvider>(
              builder: (context, value, child) => Expanded(
                child: (value.projects.isEmpty)
                    ? const Center(
                        child: Text('No Projects'),
                      )
                    : BuildProjects(
                        projects: value.projects,
                      ),
              ),
            )
          else if (searchProvider.searchType == SearchType.company)
            Consumer<CompanyProvider>(
                builder: (context, value, child) => Expanded(
                    child: (value.companies.isEmpty)
                        ? const Center(child: Text('No Companies'))
                        : Center(
                            child: Consumer<CompanyProvider>(
                            builder: (context, value, child) =>
                                BuildCompaniesCard(
                              companies: value.companies,
                            ),
                          ))))
          else if (searchProvider.searchType == SearchType.engineer)
            Consumer<EnginnerProvider>(
              builder: (context, value, child) => Expanded(
                  child: (value.engineers.isEmpty)
                      ? const Center(child: Text('No Engineers'))
                      : BuildEngineersCard(engineers: value.engineers)),
            )
        ],
      ),
    );
  }

  void search(String value) {
    switch (context.read<SearchProvider>().searchType) {

      //check search Type
      case SearchType.all:
        Provider.of<ProjectProvider>(context, listen: false).search(value);
        Provider.of<CompanyProvider>(context, listen: false).search(value);
        Provider.of<EnginnerProvider>(context, listen: false).search(value);
        break;
      case SearchType.project:
        Provider.of<ProjectProvider>(context, listen: false).search(value);
        break;
      case SearchType.company:
        Provider.of<CompanyProvider>(context, listen: false).search(value);
        break;
      case SearchType.engineer:
        Provider.of<EnginnerProvider>(context, listen: false).search(value);
        break;
    }
  }
}
