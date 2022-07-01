import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/profile/screens/company_profile.dart';

class CompanyCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String userId;
  const CompanyCard(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBoxMedium,
                  CircleAvatar(
                    backgroundColor: beg,
                    radius: 45,
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: darkBlue,
                      child: CircleAvatar(
                        radius: 41,
                        backgroundColor: darkBlue,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageUrl,
                            width: 120,
                            height: 120,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
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
                    'Homs-Syria',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
