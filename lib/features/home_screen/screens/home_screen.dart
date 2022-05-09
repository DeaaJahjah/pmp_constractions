import 'package:flutter/material.dart';

import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/providers/comoany_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/engineer_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/project_provider.dart';
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

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context);

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
                        search(textController.text);
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
                        search(textController.text);
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
                        search(textController.text);
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
                        search(textController.text);
                      })
                ],
              ),
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
    print(value);
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
