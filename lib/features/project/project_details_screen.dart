import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:pmpconstractions/features/profile/screens/company_profile.dart';
import 'package:pmpconstractions/features/profile/screens/engineer_profile.dart';
import 'package:pmpconstractions/features/project/back_to_home_screen.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProjectDetailsScreen extends StatefulWidget {
  static const routeName = '/home/project_details';
  ZoomDrawerController? zoomController;
  //static const routeName = '/';
  String? projectId;
  ProjectDetailsScreen({Key? key, this.projectId, this.zoomController})
      : super(key: key);

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  var panelController = PanelController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Project?>(
        stream:
            ProjectDbService().getProjectUpdates(widget.projectId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var project = snapshot.data;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<SelectedProjectProvider>(context, listen: false)
                  .updateProject(project!);
            });

            return (!project!.isOpen &&
                    project.privacy == ProjectPrivacy.private &&
                    (project.memberIn(context.userUid!) ||
                        project.companyId == context.userUid))
                ? const BackToHomeScreen()
                : Scaffold(
                    backgroundColor: orange,
                    // drawer: const Drawer(),
                    body: WillPopScope(
                      onWillPop: () async {
                        if (panelController.isPanelOpen) {
                          panelController.close();
                          return false;
                        }
                        if (panelController.isPanelClosed) {
                          return true;
                        }
                        return false;
                      },
                      child: Stack(
                        children: [
                          ((project.memberIn(context.userUid!) &&
                                      project.isOpen) ||
                                  project.companyId == context.userUid)
                              ? Positioned(
                                  left: 10,
                                  top: 40,
                                  child: InkWell(
                                      onTap: () {
                                        if (widget.zoomController != null) {
                                          widget.zoomController!.toggle!();
                                        }
                                      },
                                      child: const Icon(Icons.menu,
                                          color: darkBlue)),
                                )
                              : const SizedBox.shrink(),
                          SlidingUpPanel(
                              controller: panelController,
                              minHeight: 350,
                              maxHeight: MediaQuery.of(context).size.height,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: darkBlue,
                              // body: Container(
                              //   height: 50,
                              //   margin: const EdgeInsets.only(bottom: 350),
                              //   width: MediaQuery.of(context).size.width,
                              //   color: Colors.white10,
                              //   child: ModelViewer(
                              //     //  poster: 'Loading...',
                              //     //   posterColor: Colors.amber,
                              //     animationCrossfadeDuration: 1,
                              //     loading: Loading.lazy,

                              //     src: 'assets/villa.gltf',

                              //     // 'https://firebasestorage.googleapis.com/v0/b/justatest-63adb.appspot.com/o/data%2Fuser%2F0%2Fjh.deaa.testapp%2Fcache%2Ffile_picker%2FWoodHouse.glb?alt=media&token=a3bdc3da-df37-464f-868b-6ee4506997d4',
                              //     //https://doc-0s-34-docs.googleusercontent.com/docs/securesc/3rked6od461r1tff4per9rh2n3i7i7so/5ehgdto77jndj0j2lu31kuf2sqmgboj0/1652479275000/14580657950992246128/14580657950992246128/1Gh3Am_LFvrD3yMmdiBtqD-AHeyvGwMyj?e=view&ax=ACxEAsaJF_IKkBTYBbz9b_DtJ1LrZ40pJgNeyugjrZ0MUmvHybHDp_LdVnxHglptlWQYTRghC85X875hDBuVCjqHyE-LBYkR0SdKtRVhldysyPYWt8w0z8A22OOZQAuEMiKuO163KOlp1fNJBiUNvwKYTC4C5r0fJHpoeywbePWTtgpfHFGyXdGC46rR9RPYysO7L6opzSp-gInWFalkAaJY4xH2iRTxNM69rsJJxAg3nrXW2PL3nbJAtk5grw_i1nM-mMIJti7sjysbZbpDCUeKncFJHqzCkDmV6wZRT3pSbpMSxGAoAp6X0iHbpkguPG3vKH4DEM6lMLaHpzAlunGtB-rhi092iq4nLTkJ-X3jb6jUKy-FGku-bfmTjv-cmAZmYOBOPa3i_Tplq8mKpLt96u67CefcbTSQX4WWyYSpHGjfqAX4nO-lKB8v-uBGo8vcA-uds0zfeGovcVONm_5mJQLCPdX-XPnq8gSvAplCQEUPL8bM9irBmak0IaSusQWLfzygWQ0NA4fykEYXIYn9CUXzUeS_7ZAlGQ6fUuuxURQYCbaeukyv8cfXF30tn6B_lPY0_lV4gBMv_QmmIvINBVlGnuzR6oKVVPiES0HIHHdrZRa548El9uotETMY_1l1gNNUi4P5nPuW1ylYxURi4OZJdp8ZPU0Cm0hwHyNro91MgQf73y-IdHyFqlNH2qMSHc592H4klqB3MfvsUELeF94Uhywct-zpgs5oqJV2NF5AVkw-pkpvxzJWmtAoXyCAZPgBk5McvQ4DXDFVvIIyeg&authuser=0&nonce=f2stii9qhvlie&user=14580657950992246128&hash=s1i0v5lhi37tkk2i2c3ekk7hi64ck2la',
                              //     autoRotateDelay: 5,
                              //     ar: true,
                              //     autoRotate: true,
                              //     cameraControls: true,
                              //     backgroundColor: orange,
                              //   ),
                              // ),
                              collapsed: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: const [
                                    Positioned(
                                        top: 0,
                                        // left: MediaQuery.of(context).size.width / 2,
                                        child: Icon(
                                          Icons.drag_handle_rounded,
                                          color: Color.fromARGB(
                                              141, 255, 204, 128),
                                        ))
                                  ]),
                              panelBuilder: (ScrollController
                                      scrollController) =>
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: darkBlue,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      child: ListView(
                                          controller: scrollController,
                                          children: [
                                            Text(
                                              project.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge,
                                              textAlign: TextAlign.center,
                                            ),
                                            sizedBoxSmall,
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                CompanyProfile(
                                                                  companyId: project
                                                                      .companyId,
                                                                ))),
                                                    child: TextIcon(
                                                        iconData: Icons.house,
                                                        title: project
                                                            .companyName),
                                                  ),
                                                  const TextIcon(
                                                      iconData:
                                                          Icons.location_on,
                                                      title: 'Location city')
                                                ]),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 40, 45, 10),
                                              child: Column(
                                                children: [
                                                  const TextIcon(
                                                    iconData: Icons.description,
                                                    title: 'Description',
                                                  ),
                                                  Text(project.description),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 20, 45, 0),
                                              child: TextIcon(
                                                iconData: Icons.info,
                                                title: 'Engineers',
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 45, 5),
                                              height: 200,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      project.members!.length,
                                                  itemBuilder: (ctx, i) {
                                                    var member =
                                                        project.members![i];
                                                    return InkWell(
                                                      onTap: () => Navigator.of(
                                                              context)
                                                          .push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EngineerProfile(
                                                                            engineerId:
                                                                                member.memberId,
                                                                          ))),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 20),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 40,
                                                                backgroundColor:
                                                                    orange,
                                                                child:
                                                                    CircleAvatar(
                                                                        radius:
                                                                            39,
                                                                        child:
                                                                            CashedImage(
                                                                          imageUrl:
                                                                              member.profilePicUrl!,
                                                                          radius:
                                                                              39,
                                                                          size:
                                                                              100,
                                                                        )),
                                                              ),
                                                              Text(
                                                                member
                                                                    .memberName,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headlineSmall,
                                                              ),
                                                              Text(member
                                                                  .role!.name)
                                                            ]),
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ]))),
                        ],
                      ),
                    ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class TextIcon extends StatelessWidget {
  final IconData iconData;
  final String title;
  const TextIcon({Key? key, required this.iconData, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(iconData),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
