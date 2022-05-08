import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/project_card.dart';

class BuildAll extends StatelessWidget {
  const BuildAll(
      {Key? key,
      required this.projects,
      required this.companies,
      required this.engineers})
      : super(key: key);
  final List<Project> projects;
  final List<Company> companies;
  final List<Engineer> engineers;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(
        child: Title(title: 'Engineers'),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 150,
        child: ListView.builder(
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
            }),
      )),
      const SliverToBoxAdapter(
        child: Title(title: 'Companies'),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 150,
        child: ListView.builder(
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
            }),
      )),
      const SliverToBoxAdapter(
        child: Title(title: 'Buldings'),
      ),
      SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 40,
            crossAxisSpacing: 10,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            var project = projects[index];

            return AnimationConfiguration.staggeredList(
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
          }, childCount: projects.length))
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
      onTap: () {},
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
      onTap: () {},
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
