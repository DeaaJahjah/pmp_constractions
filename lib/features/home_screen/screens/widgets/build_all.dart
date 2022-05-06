import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/project_card.dart';

class BuildAll extends StatelessWidget {
  const BuildAll({Key? key, required this.projects}) : super(key: key);
  final List<Project> projects;

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
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: const SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: EngCard()))),
        ),
      )),
      const SliverToBoxAdapter(
        child: Title(title: 'Companies'),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 150,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: const SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: CompCard()))),
        ),
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
  const EngCard({Key? key}) : super(key: key);

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
                  children: const [
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
                          backgroundImage:
                              AssetImage('assets/images/sawsan.png'),
                        ),
                      ),
                    ),
                    sizedBoxSmall,
                    Text('Sawsan Ahmad',
                        style: TextStyle(
                            color: orange,
                            fontFamily: font,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    sizedBoxXSmall,
                    Text(
                      'Architectural engineer',
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

class CompCard extends StatelessWidget {
  const CompCard({Key? key}) : super(key: key);

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
                  children: const [
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
                          backgroundImage:
                              AssetImage('assets/images/smlogo.png'),
                        ),
                      ),
                    ),
                    sizedBoxSmall,
                    Text('Simecolon',
                        style: TextStyle(
                            color: orange,
                            fontFamily: font,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    sizedBoxXSmall,
                    Text(
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
