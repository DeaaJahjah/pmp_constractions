import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/company_card.dart';

class BuildCompaniesCard extends StatelessWidget {
  const BuildCompaniesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 50,
            mainAxisExtent: 220),
        itemCount: 6,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
            position: i,
            duration: const Duration(milliseconds: 375),
            child: const SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: CompanyCard()))));
  }
}
