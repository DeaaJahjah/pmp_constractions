import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({Key? key}) : super(key: key);

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
                    const CircleAvatar(
                      backgroundColor: beg,
                      radius: 45,
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: darkBlue,
                        child: CircleAvatar(
                          radius: 41,
                          backgroundColor: darkBlue,
                          backgroundImage:
                              AssetImage('assets/images/smlogo.png'),
                        ),
                      ),
                    ),
                    sizedBoxSmall,
                    Text(
                      'Simecolon',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    sizedBoxSmall,
                    Text(
                      'Homs-Syria',
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
