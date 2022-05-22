import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';

class OpenProjects extends StatelessWidget {
  final ScrollController scrollController;
  OpenProjects({Key? key, required this.scrollController}) : super(key: key);

  var user = FirebaseAuth.instance.currentUser;

  String? imgUrl;
  List<String>? projectIds;

  @override
  Widget build(BuildContext context) {
    //  switch (user!.displayName) {
    //   case 'engineer':
    //     if (Provider.of<EnginnerProvider>(context, listen: true)
    //         .engineers
    //         .isNotEmpty) {
    //       var engineer = Provider.of<EnginnerProvider>(context, listen: true)
    //           .engineers
    //           .firstWhere((element) => element.userId == user!.uid);
    //       projectIds = engineer.profilePicUrl;
    //       name = engineer.name;
    //     }
    //     break;
    //   case 'company':
    //     if (Provider.of<CompanyProvider>(context, listen: true)
    //         .companies
    //         .isNotEmpty) {
    //       var company = Provider.of<CompanyProvider>(context, listen: true)
    //           .companies
    //           .firstWhere((element) => element.userId == user.uid);
    //       imgUrl = company.profilePicUrl;
    //       name = company.name;
    //     }

    //     break;
    //   case 'client':
    //     if (Provider.of<DataProvider>(context, listen: true)
    //         .clients
    //         .isNotEmpty) {
    //       var client = Provider.of<DataProvider>(context, listen: true)
    //           .clients
    //           .firstWhere((element) => element.userId == user.uid);
    //       imgUrl = client.profilePicUrl;
    //       name = client.name;
    //     }

    //     break;
    // }
    return FutureBuilder<List<Project>>(
      future: ProjectDbService().getOpenProjects(['21sFqVCd5qwcwtYWTO02']),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Project> projects = snapshot.data!;
          return ListView.builder(
            controller: scrollController,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              Project project = projects[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(project.imageUrl)),
                    const SizedBox(width: 10),
                    Text(project.name)
                  ],
                ),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
