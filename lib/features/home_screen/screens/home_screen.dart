import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/search_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_all.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/bulid_companies_card.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/bulid_engineers_card.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/custom_item.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/search_text_field.dart';
import 'package:provider/provider.dart';

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

  List<Project> searchedProjects = [];
  List<Company> searchedCompanies = [];
  List<Engineer> searchedEngineers = [];
  bool loading = false;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context);
    searchedProjects = Provider.of<DataProvider>(context).projects;
    searchedCompanies = Provider.of<DataProvider>(context).companies;
    searchedEngineers = Provider.of<DataProvider>(context).engineers;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {},
                child: const Icon(Icons.notifications, color: darkBlue)),
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
                      onTap: () {
                        setState(() {
                          changeItemState(0);
                        });
                        searchProvider.searchState(SearchType.all);
                      }),
                  CustomItem(
                      text: 'Bulding',
                      icon: Icons.business,
                      selected: itemsState[1],
                      onTap: () {
                        setState(() {
                          changeItemState(1);
                        });
                        searchProvider.searchState(SearchType.project);
                      }),
                  CustomItem(
                      text: 'Company',
                      icon: Icons.business,
                      selected: itemsState[2],
                      onTap: () {
                        setState(() {
                          changeItemState(2);
                        });
                        searchProvider.searchState(SearchType.company);
                      }),
                  CustomItem(
                      text: 'Engineer',
                      icon: Icons.business,
                      selected: itemsState[3],
                      onTap: () {
                        setState(() {
                          changeItemState(3);
                        });
                        searchProvider.searchState(SearchType.engineer);
                      })
                ],
              ),
            ),
          ]),
          if (searchProvider.searchType == SearchType.all)
            Expanded(
              child: (loading)
                  ? const Center(child: CircularProgressIndicator())
                  : BuildAll(
                      projects: searchedProjects,
                      companies: searchedCompanies,
                      engineers: searchedEngineers),
            )
          else if (searchProvider.searchType == SearchType.project)
            Expanded(
              child: (loading)
                  ? const Center(child: CircularProgressIndicator())
                  : BuildProjects(
                      projects: searchedProjects,
                    ),
            )
          else if (searchProvider.searchType == SearchType.company)
            Expanded(
                child: (loading)
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: BuildCompaniesCard(
                        companies: searchedCompanies,
                      )))
          else if (searchProvider.searchType == SearchType.engineer)
            Expanded(
                child: (loading)
                    ? const Center(child: CircularProgressIndicator())
                    : BuildEngineersCard(engineers: searchedEngineers)),
        ],
      ),
    );
  }

  void onSearchProjects(String value) {
    var projects = Provider.of<DataProvider>(context).projects;
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
