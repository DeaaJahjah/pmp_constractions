import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/core/widgets/phone_card.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/member_card.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:pmpconstractions/features/project/wating_create_project.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/search_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UpdateProjectScreen extends StatefulWidget {
  static const routeName = '/update-project';
  Project project;
  UpdateProjectScreen({Key? key, required this.project}) : super(key: key);

  @override
  State<UpdateProjectScreen> createState() => _UpdateProjectScreenState();
}

class _UpdateProjectScreenState extends State<UpdateProjectScreen> {
  final liquidController = LiquidController();
  ScrollController scrollController = ScrollController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  int activePage = 0;

  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  Uint8List? model3D;
  String? modelName;
  List<MemberRole> members = [];
  List<MemberRole> selectedMembers = [];
  Role selectedRole = Role.projectEngineer;
  MemberRole? selectedItem;
  ProjectPrivacy privacy = ProjectPrivacy.private;
  bool isOpen = false;
  bool isPrivate = false;

  Future<void> getMembers() async {
    await Provider.of<DataProvider>(context, listen: false).fetchClients();

    var clients = Provider.of<DataProvider>(context, listen: false).clients;

    await Provider.of<DataProvider>(context, listen: false).fetchEngineers();
    var enginners = Provider.of<DataProvider>(context, listen: false).engineers;

    for (var client in clients) {
      if (!widget.project.memberIn(client.userId!)) {
        members.add(MemberRole(
            memberId: client.userId!,
            memberName: client.name,
            profilePicUrl: client.profilePicUrl!,
            collectionName: 'clients',
            submited: false));
      }
    }
    for (var enginner in enginners) {
      if (!widget.project.memberIn(enginner.userId!)) {
        members.add(MemberRole(
            memberId: enginner.userId!,
            memberName: enginner.name,
            profilePicUrl: enginner.profilePicUrl,
            collectionName: 'engineers',
            submited: false));
      }
    }
  }

  _pickImage() async {
    final picker = ImagePicker();
    try {
      pickedimage = await picker.pickImage(source: ImageSource.gallery);
      fileName = path.basename(pickedimage!.path);
      imageFile = File(pickedimage!.path);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null) {
        model3D = result.files.first.bytes;
        modelName = result.files.first.name;
        setState(() {});
      } else {
        // User canceled the picker
        // model3D = null;
        // modelName = null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    nameController.text = widget.project.name;
    descController.text = widget.project.description;
    privacy = widget.project.privacy;
    isOpen = widget.project.isOpen;
    isPrivate =
        (widget.project.privacy == ProjectPrivacy.private) ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.project.modelUrl);
    var pages = [
      Container(
        color: darkBlue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            sizedBoxXLarge,
            TextFieldCustome(
              controller: nameController,
              text: context.loc.name,
            ),
            sizedBoxXLarge,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: descController,
                maxLines: 4,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(14),
                  label: Text(context.loc.descripton,
                      style: Theme.of(context).textTheme.bodySmall),
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.start,
                autofocus: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Is Project open?',
                      style: Theme.of(context).textTheme.bodySmall),
                  FlutterSwitch(
                      value: isOpen,
                      height: 30,
                      width: 50,
                      toggleSize: 20,
                      borderRadius: 50,
                      activeColor: darkBlue,
                      inactiveColor: darkBlue,
                      toggleColor: orange,
                      switchBorder: Border.all(
                        color: orange,
                      ),
                      inactiveIcon: const Icon(
                        Icons.visibility_off,
                        color: darkBlue,
                      ),
                      activeIcon: const Icon(
                        Icons.visibility,
                        color: darkBlue,
                      ),
                      onToggle: (bool value) {
                        setState(() {
                          isOpen = value;
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Privacy', style: Theme.of(context).textTheme.bodySmall),
                  FlutterSwitch(
                      value: isPrivate,
                      height: 30,
                      width: 50,
                      toggleSize: 20,
                      borderRadius: 50,
                      activeColor: darkBlue,
                      inactiveColor: darkBlue,
                      toggleColor: orange,
                      switchBorder: Border.all(
                        color: orange,
                      ),
                      inactiveIcon: const Icon(
                        Icons.lock_open,
                        color: darkBlue,
                      ),
                      activeIcon: const Icon(
                        Icons.lock,
                        color: darkBlue,
                      ),
                      onToggle: (bool value) {
                        setState(() {
                          isPrivate = value;
                          if (isPrivate) {
                            privacy = ProjectPrivacy.private;
                          } else {
                            privacy = ProjectPrivacy.public;
                          }
                        });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBlue,
        child: Column(children: [
          sizedBoxXLarge,
          InkWell(
            onTap: () {
              _pickImage();
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor: karmedi,
              radius: 60,
              child: (pickedimage == null && widget.project.imageUrl.isEmpty)
                  ? const Icon(
                      Icons.person_add,
                      size: 50,
                      color: beg,
                    )
                  : CircleAvatar(
                      radius: 60,
                      child: (widget.project.imageUrl.isNotEmpty &&
                              imageFile == null)
                          ? CashedImage(
                              imageUrl: widget.project.imageUrl,
                              radius: 60,
                              size: 150,
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(imageFile!)),
                    ),
            ),
          ),
          sizedBoxMedium,
          Text(context.loc.add_pic,
              style: Theme.of(context).textTheme.headlineMedium),
          sizedBoxMedium,
          sizedBoxMedium,
          sizedBoxMedium,
          sizedBoxMedium,
          InkWell(
            onTap: () {
              _pickFile();
              setState(() {});
            },
            child: const CircleAvatar(
                backgroundColor: karmedi,
                radius: 60,
                child: Icon(
                  Icons.theater_comedy,
                  size: 50,
                  color: beg,
                )),
          ),
          Text(context.loc.model,
              style: Theme.of(context).textTheme.headlineMedium),
          if (modelName != null)
            PhoneCard(
                text: '$modelName',
                onTap: () {
                  setState(() {
                    modelName = null;
                    model3D = null;
                  });
                }),
        ]),
      ),
      Container(
        color: darkBlue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          controller: scrollController,
          children: [
            Text('Members', style: Theme.of(context).textTheme.headlineMedium),
            SearchDropDown(
                members: members,
                selectedItem: selectedItem,
                onChanged: (member) {
                  setState(() {
                    selectedItem = member;
                  });
                }),
            sizedBoxMedium,
            FormField<String>(builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        gapPadding: 4,
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Role>(
                    dropdownColor: beg,
                    elevation: 10,
                    iconEnabledColor: orange,
                    style: const TextStyle(
                        color: orange,
                        fontFamily: font,
                        fontWeight: FontWeight.bold),
                    alignment: AlignmentDirectional.center,
                    focusColor: orange,
                    value: selectedRole,
                    isDense: true,
                    onChanged: (newValue) {
                      setState(() {
                        selectedRole = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text(Role.projectManager.name),
                        value: Role.projectManager,
                      ),
                      DropdownMenuItem(
                        child: Text(Role.projectEngineer.name),
                        value: Role.projectEngineer,
                      ),
                      DropdownMenuItem(
                        child: Text(Role.siteEngineer.name),
                        value: Role.siteEngineer,
                      ),
                      DropdownMenuItem(
                        child: Text(Role.client.name),
                        value: Role.client,
                      )
                    ],
                  ),
                ),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedItem!.role = selectedRole;
                    selectedMembers.add(selectedItem!);
                    members.remove(selectedItem!);
                    selectedRole = Role.projectManager;
                    selectedItem = members.first;
                  });
                },
                child: const Text('Add')),
            ElevatedButton(
                onPressed: () async {
                  String companyId = FirebaseAuth.instance.currentUser!.uid;

                  Provider.of<AuthSataProvider>(context, listen: false)
                      .changeAuthState(newState: AuthState.waiting);

                  String imageUrl = '';
                  if (imageFile != null) {
                    imageUrl = await FileService()
                        .uploadeimage(fileName, imageFile!, context);
                  }

                  String modelUrl = '';
                  if (model3D != null) {
                    // imageUrl = await FileService()
                    //     .uploadeFile(modelName!, model3D!, context);
                  }
                  if (imageUrl == 'error' || modelUrl == 'error') {
                    final snackBar = SnackBar(
                      content: const Text('error while uploading files'),
                      backgroundColor: Colors.red[500],
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }

                  await ProjectDbService().updateProject(
                    Project(
                        projectId: widget.project.projectId,
                        name: nameController.text,
                        companyName: widget.project.companyName,
                        companyId: companyId,
                        description: descController.text,
                        imageUrl: imageUrl,
                        modelUrl: modelUrl,
                        privacy: privacy,
                        isOpen: isOpen,
                        members: selectedMembers,
                        location: widget.project.location),
                    context,
                  );
                },
                child: const Text('Create')),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  controller: scrollController,
                  itemCount: selectedMembers.length,
                  itemBuilder: (context, i) => MemberCard(
                      name: selectedMembers[i].memberName,
                      role: selectedMembers[i].role!,
                      photoUrl: selectedMembers[i].profilePicUrl,
                      onTap: () {
                        setState(() {
                          members.add(selectedMembers[i]);
                          selectedMembers.removeAt(i);
                        });
                      })),
            )
          ],
        ),
      ),
    ];
    return Consumer<AuthSataProvider>(
        builder: (context, value, child) => (AuthState.waiting ==
                Provider.of<AuthSataProvider>(context).authState)
            ? const WattingCreateScreen()
            : Scaffold(
                bottomNavigationBar: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            if (liquidController.currentPage > 0) {
                              liquidController.animateToPage(
                                  page: liquidController.currentPage - 1);
                            }
                            setState(() {});
                          },
                          child: (activePage != 0)
                              ? const Text('back',
                                  style: TextStyle(
                                    color: beg,
                                    fontFamily: font,
                                    fontWeight: FontWeight.bold,
                                  ))
                              : const SizedBox()),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                    Expanded(
                      flex: 3,
                      child: AnimatedSmoothIndicator(
                        activeIndex: activePage,
                        count: pages.length,
                        duration: const Duration(milliseconds: 300),
                        effect: const WormEffect(
                          activeDotColor: orange,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            if (activePage == 0 &&
                                nameController.text.isNotEmpty) {
                              liquidController.animateToPage(
                                  page: liquidController.currentPage + 1);
                              setState(() {});
                              return;
                            }
                            if (activePage == 0 &&
                                nameController.text.isEmpty) {
                              const snackBar = SnackBar(
                                  content: Text('The name is required'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }

                            if (activePage == 0 && descController.text == '') {
                              const snackBar = SnackBar(
                                  content: Text('The description is required'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if (activePage == 1 &&
                                (imageFile == null &&
                                    widget.project.imageUrl.isEmpty)) {
                              const snackBar = SnackBar(
                                  content: Text('please select image'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if (activePage == 1 &&
                                modelName == null &&
                                widget.project.modelUrl.isEmpty) {
                              const snackBar = SnackBar(
                                  content: Text('please select 3D model'));
                              print(widget.project.modelUrl);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }

                            if (activePage + 1 < pages.length) {
                              liquidController.animateToPage(
                                  page: liquidController.currentPage + 1);
                            }
                            setState(() {});
                          },
                          child: (activePage != 2)
                              ? const Text('Next',
                                  style: TextStyle(
                                    color: beg,
                                    fontFamily: font,
                                    fontWeight: FontWeight.bold,
                                  ))
                              : const SizedBox()),
                    ),
                  ],
                ),
                appBar: AppBar(
                  elevation: 0.0,
                  title: const Text(
                    'Edit Project',
                  ),
                  centerTitle: true,
                ),
                body: Builder(
                    builder: ((context) => Stack(
                          children: [
                            LiquidSwipe(
                              disableUserGesture: true,
                              pages: pages,
                              liquidController: liquidController,
                              onPageChangeCallback: (index) {
                                activePage = index;
                                setState(() {});
                              },
                            ),
                          ],
                        ))),
              ));
  }
}
