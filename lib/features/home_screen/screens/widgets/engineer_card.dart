import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class EngineerCard extends StatelessWidget {
  const EngineerCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.speclizition,
      required this.userId})
      : super(key: key);
  final String imageUrl;
  final String name;
  final String speclizition;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
          width: 150,
          height: 200,
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
                      backgroundColor: orange,
                      radius: 45,
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: darkBlue,
                        child: CircleAvatar(
                          radius: 41,
                          backgroundColor: darkBlue,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                      ),
                    ),
                    sizedBoxSmall,
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    sizedBoxSmall,
                    Text(
                      speclizition,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
