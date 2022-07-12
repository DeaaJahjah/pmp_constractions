import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/home_screen/services/company_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:pmpconstractions/features/profile/screens/client_profile.dart';
import 'package:pmpconstractions/features/profile/screens/company_profile.dart';
import 'package:pmpconstractions/features/profile/screens/engineer_profile.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';

class ProfileImageMenu extends StatelessWidget {
  const ProfileImageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<String?>(
        stream: getProfileImage(),
        builder: (context, snapshot) {
          return InkWell(
              onTap: () async {
                switch (user.displayName) {
                  case 'engineer':
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EngineerProfile(
                              engineerId: user.uid,
                            )));
                    break;
                  case 'company':
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CompanyProfile(
                              companyId: user.uid,
                            )));
                    break;
                  case 'client':
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ClientProfile(
                              clientId: user.uid,
                            )));
                    break;
                }
              },
              child: (snapshot.data != null)
                  ? CircleAvatar(
                      backgroundColor: orange,
                      radius: 40,
                      child: CashedImage(
                        imageUrl: snapshot.data!,
                        radius: 40,
                        size: 100,
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: orange,
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/prof.png'),
                    ));
        });
  }
}

getProfileImage() {
  var user = FirebaseAuth.instance.currentUser!;

  switch (user.displayName) {
    case 'engineer':
      return EngineerDbService().getEngineerPhotoUrl(user.uid);

    case 'company':
      return CompanyDbService().getCompanyPhotoUrl(user.uid);

    case 'client':
      return ClientDbService().getClientPhotoUrl(user.uid);
  }
}
