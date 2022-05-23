import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
class EngineerProfile extends StatefulWidget {
  final String? engineerId;
  
  const EngineerProfile({Key? key, this.engineerId}) : super(key: key);
  static const routeName = '/enginner_profile';
  @override
  State<EngineerProfile> createState() => _EngineerProfileState();
}

class _EngineerProfileState extends State<EngineerProfile> {
  var pref = SharedPreferences.getInstance();
 bool elevatedButtonCase =true;
  String? id;
  @override
  void initState() {
    // pref.then((value) {
    //   setState(() {
    //     id = value.getString('uid');
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     
    print(widget.engineerId);
    return Scaffold(
      body: FutureBuilder<Engineer>(
          future:
              EngineerDbService().getEngineerById('JiNR2hvk2LTEQF3Jm5tSDfk4u543'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var enginner = snapshot.data!;
              return ListView(children: [
                SizedBox(
                  height: 225,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: const BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                    Positioned(
                        top: 15,
                        left: 7,
                        child: IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: darkBlue,
                            ),
                            onPressed: () {})),
                     Positioned(
                      top: 20,
                      left: 135,
                      child: Text(
                        context.loc.my_profile,
                        style: TextStyle(
                            color: darkBlue,
                            fontFamily: font,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: 78,
                      left: 107,
                      child: CircleAvatar(
                        backgroundColor: darkBlue,
                        radius: 72,
                        child: CircleAvatar(
                          backgroundColor: orange,
                          radius: 70,
                          child: (enginner.profilePicUrl != '')
                              ? CircleAvatar(
                                  backgroundColor: darkBlue,
                                  radius: 68,
                                  backgroundImage:
                                      NetworkImage(enginner.profilePicUrl ?? ''))
                              : const CircleAvatar(
                                  backgroundColor: darkBlue,
                                  radius: 68,
                                  backgroundImage: AssetImage(
                                      'assets/images/engineer_orange.png')),
                        ),
                      ),
                    )
                  ]),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    enginner.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    enginner.specialization,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  sizedBoxSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButtonCustom(
                        text: context.loc.experience,
                        onPressed: () {
                           elevatedButtonCase=true;
                          setState(() {
                            
                          });
                          },
                          bgColor:(elevatedButtonCase == true)?beg : darkBlue,
                      ),
                      ElevatedButtonCustom(
                        text: context.loc.contact_info,
                        onPressed: () {
             elevatedButtonCase=false;
             setState(() {  
             });
                        },
                        bgColor :(elevatedButtonCase==true)? darkBlue : beg,
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: beg,
                  ),
                ]),
               (elevatedButtonCase==true)?
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomeRow(
                          icon: Icons.language,
                          text: context.loc.languages,
                    ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: enginner.experience!['languages']!
                                .map((e) => Text(e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall))
                                .toList(),
                          )),
                      CustomeRow(
                          icon: Icons.filter_frames_sharp,
                          text: context.loc.certificate,
                          ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: enginner.experience!['certificates']!
                                .map((e) => Text(e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall))
                                .toList(),
                          )),
                      CustomeRow(
                          icon: Icons.computer,
                          text: context.loc.programs,
                        ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: enginner.experience!['programs']!
                                .map((e) => Text(e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall))
                                .toList(),
                          )),
                          ]
                          
                          ),
                ): 
                Container(  
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                    
                       enginner.phoneNumbers!
                          .map((e) => InkWell(
                                onTap: () async {
                                  await launch('tel:$e');
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.call,color: orange,size: 25),
                                    SizedBox(width:8),
                                    Text(e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ), 
                ),

                    CustomeRow(icon: Icons.portrait, text: context.loc.my_projects),
                    const Divider(
                      thickness: 0.5,
                      color: beg,
                    ),
                    sizedBoxLarge,
                
                
           Expanded(
             flex: 1,
             child: Container(
               height: 1500,
               child:FutureBuilder<List<Project>>(
                 future: ProjectDbService().getPublicProjects(enginner.projectsIDs!),
                 builder:(context, snapshot) {

                   if(snapshot.hasData) 
                   {
                     List<Project> projects=snapshot.data!;
return BuildProjects(projects: projects);

                   }
                   if(snapshot.connectionState== ConnectionState.waiting)
                   {
                     return Center(child: CircularProgressIndicator());
                    
                   }
                   return SizedBox();
                   
                 }, ) ,
             ),
           )
              ]);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
