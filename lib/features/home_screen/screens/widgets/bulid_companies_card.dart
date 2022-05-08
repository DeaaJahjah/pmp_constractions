import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/company_card.dart';

class BuildCompaniesCard extends StatelessWidget {
  const BuildCompaniesCard({Key? key, required this.companies})
      : super(key: key);
  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 50,
            mainAxisExtent: 220),
        itemCount: companies.length,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemBuilder: (ctx, i) {
          var company = companies[i];
          return AnimationConfiguration.staggeredList(
              position: i,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                      child: CompanyCard(
                    name: company.name,
                    imageUrl: company.profilePicUrl!,
                    userId: company.userId!,
                  ))));
        });
  }
}
