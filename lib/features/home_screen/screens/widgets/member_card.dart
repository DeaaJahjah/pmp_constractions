import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final Role role;
  final String? photoUrl;
  Function()? onTap;
  MemberCard(
      {Key? key,
      required this.name,
      required this.role,
      this.photoUrl,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: orange,
            child: CircleAvatar(
              radius: 24,
              child: CashedImage(
                imageUrl: photoUrl!,
                radius: 25,
                size: 50,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                role.name,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          const SizedBox(width: 30),
          InkWell(
            onTap: onTap,
            child: const CircleAvatar(
                radius: 12,
                backgroundColor: orange,
                child: Icon(
                  Icons.close,
                  size: 12,
                  color: white,
                )),
          )
        ],
      ),
    );
  }
}
