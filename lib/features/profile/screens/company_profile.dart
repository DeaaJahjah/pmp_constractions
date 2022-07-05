import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/build_projects.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/home_screen/services/company_db_service.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:pmpconstractions/features/project/create_project_screen.dart';
import 'package:pmpconstractions/features/profile/screens/update_company_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class CompanyProfile extends StatefulWidget {
  static const routeName = '/company_profile';
  String? companyId;
  CompanyProfile({Key? key, this.companyId}) : super(key: key);

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  bool elevatedButtonCase = true;

  Company? company;
  ScrollController scrollController = ScrollController();

  bool loading = true;

  @override
  void initState() {
    CompanyDbService().getCompanyById(widget.companyId!).then((value) {
      company = value;
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: (uid == widget.companyId)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateCompanyProfileScreen(
                                company: company!,
                              )));
                    },
                    child: const CircleAvatar(
                        backgroundColor: beg,
                        child: Icon(
                          Icons.edit,
                        ),
                        radius: 20),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    backgroundColor: orange,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateProjectScreen(
                                    companyName: company!.name,
                                    profilePicUrl: company!.profilePicUrl,
                                  ))).then((value) {
                        setState(() {});
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: beg,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        body: CustomScrollView(slivers: [
          (!loading)
              ? SliverList(
                  delegate: SliverChildListDelegate([
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
                              child: (company!.profilePicUrl != '')
                                  ? CircleAvatar(
                                      backgroundColor: darkBlue,
                                      radius: 68,
                                      child: CashedImage(
                                          radius: 68,
                                          size: 150,
                                          imageUrl:
                                              company!.profilePicUrl ?? ''),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: darkBlue,
                                      radius: 68,
                                      backgroundImage: AssetImage(
                                          'assets/images/comp_orange.png'),
                                    )),
                        ),
                      ]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          company!.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          company!.description,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        sizedBoxMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButtonCustom(
                              text: context.loc.experience,
                              onPressed: () {
                                elevatedButtonCase = true;
                                setState(() {});
                              },
                              bgColor:
                                  (elevatedButtonCase == true) ? beg : darkBlue,
                            ),
                            ElevatedButtonCustom(
                              text: context.loc.contact_info,
                              onPressed: () {
                                elevatedButtonCase = false;
                                setState(() {});
                              },
                              bgColor:
                                  (elevatedButtonCase == true) ? darkBlue : beg,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: beg,
                        ),
                        sizedBoxSmall,
                        (elevatedButtonCase)
                            ? Column(
                                children: [
                                  CustomeRow(
                                      icon: Icons.location_on_outlined,
                                      text: 'Location'),
                                  const Divider(
                                    thickness: 0.5,
                                    color: beg,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FlutterMap(
                                        options: MapOptions(
                                          center: latLng.LatLng(51.5, -0.09),
                                          zoom: 13.0,
                                        ),
                                        layers: [
                                          TileLayerOptions(
                                            urlTemplate:
                                                'https://api.mapbox.com/styles/v1/semicolon1212/cl37ar3u7000b14ml7vgxou0y/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2VtaWNvbG9uMTIxMiIsImEiOiJjbDM3YWk5YmYxNGRjM2NxenFwcmtkczB2In0.xF4OPPtXQETo4loq0BeS2g',
                                            additionalOptions: {
                                              'accessToken':
                                                  'pk.eyJ1Ijoic2VtaWNvbG9uMTIxMiIsImEiOiJjbDM3YWk5YmYxNGRjM2NxenFwcmtkczB2In0.xF4OPPtXQETo4loq0BeS2g',
                                              'id': 'mapbox.mapbox-streets-v8',
                                            },
                                          ),
                                          MarkerLayerOptions(
                                            markers: [
                                              Marker(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  point: latLng.LatLng(
                                                      51.5, -0.09),
                                                  builder: (ctx) => Image.asset(
                                                      'assets/images/marker.png')),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: beg)),
                                  ),
                                  sizedBoxSmall,
                                ],
                              )
                            : Column(
                                children: [
                                  CustomeRow(
                                    icon: Icons.filter_frames_sharp,
                                    text: 'Contact info',
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: company!.phoneNumbers!
                                            .map((e) => InkWell(
                                                  onTap: () async {
                                                    // ignore: deprecated_member_use
                                                    await launch('tel:$e');
                                                  },
                                                  child: Text(e,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall),
                                                ))
                                            .toList(),
                                      )),
                                ],
                              ),
                        sizedBoxSmall,
                        CustomeRow(icon: Icons.portrait, text: 'My project'),
                        const Divider(
                          thickness: 0.5,
                          color: beg,
                        ),
                      ],
                    )
                  ]),
                )
              : const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
          (!loading)
              ? SliverFillRemaining(
                  child: FutureBuilder<List<Project>>(
                    future: (uid == company!.userId)
                        ? ProjectDbService().geCompanyProjects(uid)
                        : ProjectDbService().geCompanyPublicProjects(uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Project> projects = snapshot.data!;

                        return BuildProjects(
                          projects: projects,
                          scrollController: scrollController,
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const SizedBox();
                    },
                  ),
                )
              : const SliverToBoxAdapter(
                  child: SizedBox(),
                )
        ]));
  }
}
