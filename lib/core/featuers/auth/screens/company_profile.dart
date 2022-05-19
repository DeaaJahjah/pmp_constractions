import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/services/company_db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyProfile extends StatefulWidget {
  static const routeName = '/company_profile';
  String? companyId;
  CompanyProfile({Key? key, this.companyId}) : super(key: key);

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  var pref = SharedPreferences.getInstance();
  String? id;
  @override
  void initState() {
    pref.then((value) {
      setState(() {
        id = value.getString('uid');
      });
    });
    print(widget.companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('uid: $id');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: orange,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 30,
          color: beg,
        ),
      ),
      body: FutureBuilder<Company>(
          future:
              CompanyDbService().getCompanyById(widget.companyId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var company = snapshot.data!;
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
                    const Positioned(
                      top: 20,
                      left: 135,
                      child: Text(
                        'My profile',
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
                          backgroundColor: orange,
                          radius: 70,
                          child: CircleAvatar(
                            backgroundColor: darkBlue,
                            radius: 68,
                            backgroundImage:
                                NetworkImage(company.profilePicUrl ?? ''),
                          )),
                    ),
                  ]),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      company.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      company.description,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    sizedBoxMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButtonCustom(
                          text: 'About',
                          onPressed: () {},
                          color: beg,
                          bgColor: beg,
                        ),
                        ElevatedButtonCustom(
                          text: 'Contact info',
                          onPressed: () {},
                          color: beg,
                          bgColor: darkBlue,
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: beg,
                    ),
                    sizedBoxSmall,
                    CustomeRow(
                        icon: Icons.location_on_outlined, text: 'Location'),
                    const Divider(
                      thickness: 0.5,
                      color: beg,
                    ),
                    Container(
                      width: 320,
                      height: 145,
                      child: Image.asset(
                        'assets/images/map.png',
                        fit: BoxFit.fill,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: beg)),
                    ),
                    sizedBoxSmall,
                    CustomeRow(
                        icon: Icons.filter_frames_sharp,
                        text: 'Contact info',
                        editIcon: Icons.phone),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: company.phoneNumbers!
                              .map((e) => InkWell(
                                    onTap: () async {
                                      await launch('tel:$e');
                                    },
                                    child: Text(e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ))
                              .toList(),
                        )),
                    sizedBoxSmall,
                    CustomeRow(icon: Icons.portrait, text: 'My project'),
                    const Divider(
                      thickness: 0.5,
                      color: beg,
                    ),
                    sizedBoxMedium,
                    Text(
                      'No projects Yet',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
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
