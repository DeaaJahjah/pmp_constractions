import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/engineer_card.dart';

class BuildEngineersCard extends StatelessWidget {
  const BuildEngineersCard({Key? key, required this.engineers})
      : super(key: key);
  final List<Engineer> engineers;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 50,
            mainAxisExtent: 220),
        itemCount: engineers.length,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemBuilder: (ctx, i) {
          var engineer = engineers[i];
          return AnimationConfiguration.staggeredList(
              position: i,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                      child: EngineerCard(
                    name: engineer.name,
                    speclizition: engineer.specialization,
                    imageUrl: engineer.profilePicUrl ?? '',
                    userId: engineer.userId ?? '',
                  ))));
        });
  }
}
