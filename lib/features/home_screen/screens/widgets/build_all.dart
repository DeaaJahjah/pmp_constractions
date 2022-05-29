import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/profile/screens/company_profile.dart';
import 'package:pmpconstractions/core/featuers/profile/screens/engineer_profile.dart';
import 'package:pmpconstractions/features/home_screen/providers/comoany_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/engineer_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/project_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/project_card.dart';
import 'package:provider/provider.dart';

class BuildAll extends StatelessWidget {
  const BuildAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(
        child: Title(title: 'Engineers'),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 150,
        child: Consumer<EnginnerProvider>(builder: (context, value, child) {
          var engineers = value.engineers;
          return (engineers.isEmpty)
              ? const Center(
                  child: Text('No Engineers Found'),
                )
              : ListView.builder(
                  itemCount: engineers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var engineer = engineers[index];
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                                child: EngCard(
                              name: engineer.name,
                              speclizition: engineer.specialization,
                              imageUrl: engineer.profilePicUrl ?? '',
                              userId: engineer.userId ?? '',
                            ))));
                  });
        }),
      )),
      const SliverToBoxAdapter(
        child: Title(title: 'Companies'),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 150,
        child: Consumer<CompanyProvider>(builder: (context, value, child) {
          var companies = value.companies;
          return (companies.isEmpty)
              ? const Center(
                  child: Text('No Companies found'),
                )
              : ListView.builder(
                  itemCount: companies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var company = companies[index];
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                                child: CompCard(
                              name: company.name,
                              imageUrl: company.profilePicUrl!,
                              userId: company.userId!,
                            ))));
                  });
        }),
      )),
      const SliverToBoxAdapter(
        child: Title(title: 'Buldings'),
      ),
      Consumer<ProjectProvider>(
        builder: (context, value, child) => SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 40,
              crossAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              var project = value.projects[index];

              return (value.projects.isEmpty)
                  ? const Center(
                      child: Text('No Projects Found'),
                    )
                  : AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Container(
                            height: (index % 2 == 0) ? 300 : 200,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ProjectCard(
                                projectId: project.projectId.toString(),
                                name: project.name,
                                imageUrl: project.imageUrl,
                                index: index),
                          ),
                        ),
                      ),
                    );
            }, childCount: value.projects.length)),
      )
    ]);
  }
}

class Title extends StatelessWidget {
  final String title;
  const Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 20,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                color: orange, borderRadius: BorderRadius.circular(5)),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}

class EngCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String speclizition;
  final String userId;
  const EngCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.speclizition,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EngineerProfile(
                  engineerId: userId,
                )));
      },
      child: Container(
          width: 120,
          height: 150,
          margin: const EdgeInsets.only(right: 10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/engborder.png',
                fit: BoxFit.fill,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedBoxMedium,
                    CircleAvatar(
                      backgroundColor: beg,
                      radius: 30,
                      child: CircleAvatar(
                        radius: 29,
                        backgroundColor: darkBlue,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: darkBlue,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                      ),
                    ),
                    sizedBoxSmall,
                    Text(name,
                        style: const TextStyle(
                            color: orange,
                            fontFamily: font,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    sizedBoxXSmall,
                    Text(
                      speclizition,
                      style: const TextStyle(
                          color: beg,
                          fontFamily: font,
                          fontSize: 8,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class CompCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String userId;
  const CompCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CompanyProfile(
                  companyId: userId,
                )));
      },
      child: Container(
          width: 120,
          height: 150,
          margin: const EdgeInsets.only(right: 10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/engborder.png',
                fit: BoxFit.fill,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedBoxMedium,
                    CircleAvatar(
                      backgroundColor: beg,
                      radius: 30,
                      child: CircleAvatar(
                        radius: 29,
                        backgroundColor: darkBlue,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: darkBlue,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                      ),
                    ),
                    sizedBoxSmall,
                    Text(name,
                        style: const TextStyle(
                            color: orange,
                            fontFamily: font,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    sizedBoxXSmall,
                    const Text(
                      'Homs-Syria',
                      style: TextStyle(
                          color: beg,
                          fontFamily: font,
                          fontSize: 8,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
