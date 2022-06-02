import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/watting_screen.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/member_card.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateProject extends StatefulWidget {
  static const routeName = '/create_project';
  const CreateProject({Key? key}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final liquidController = LiquidController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  int activePage = 0;

  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  List<MemberRole> members = [];
  List<MemberRole> selectedMembers = [];
  Role selectedRole = Role.projectEngineer;
  getMembers() {
    var clients = Provider.of<DataProvider>(context, listen: false).clients;
    var enginners = Provider.of<DataProvider>(context, listen: false).engineers;

    for (var client in clients) {
      members.add(MemberRole(
          memberId: client.userId!,
          memberName: client.name,
          profilePicUrl: client.profilePicUrl!));
    }
    for (var enginner in enginners) {
      members.add(MemberRole(
          memberId: enginner.userId!,
          memberName: enginner.name,
          profilePicUrl: enginner.profilePicUrl));
    }
    return members;
  }

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    MemberRole selectedItem = members.first;
    var pages = [
      Container(
        color: darkBlue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          controller: scrollController,
          children: [
            DropdownSearch<MemberRole>(
              mode: Mode.BOTTOM_SHEET,
              items: members,
              popupItemBuilder: buildItem,
              popupBackgroundColor: const Color.fromARGB(146, 11, 29, 55),
              //showSelectedItems: true,
              searchFieldProps: const TextFieldProps(),
              showSearchBox: true,
              itemAsString: (member) {
                return member!.memberName;
              },
              selectedItem: selectedItem,
              onChanged: (member) {
                selectedItem = member!;
              },
            ),
            sizedBoxMedium,
            FormField<String>(
                initialValue: 'Select',
                builder: (FormFieldState<String> state) {
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
                    selectedItem.role = selectedRole;
                    selectedMembers.add(selectedItem);
                    selectedRole = Role.projectManager;
                    selectedItem = members.first;
                  });
                },
                child: const Text('Add')),
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
                          selectedMembers.removeAt(i);
                        });
                      })),
            )
          ],
        ),
      ),
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
          ],
        ),
      ),
    ];
    return Consumer<AuthSataProvider>(
        builder: (context, value, child) => (AuthState.waiting ==
                Provider.of<AuthSataProvider>(context).authState)
            ? const WattingScreen()
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
                            if (activePage == 1 &&
                                nameController.text.isNotEmpty) {
                              liquidController.animateToPage(
                                  page: liquidController.currentPage + 1);
                              setState(() {});
                              return;
                            }
                            if (activePage == 1 &&
                                nameController.text.isEmpty) {
                              const snackBar = SnackBar(
                                  content: Text('The name is required'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if (activePage == 3 &&
                                descController.text.isNotEmpty) {
                              liquidController.animateToPage(
                                  page: liquidController.currentPage + 1);
                              setState(() {});
                              return;
                            }
                            if (activePage == 3 &&
                                descController.text.isEmpty) {
                              const snackBar = SnackBar(
                                  content: Text('The name is required'));
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
                          child: (activePage != 4)
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
                    'Create Project',
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

  Widget buildItem(BuildContext context, MemberRole item, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: orange,
            child: CircleAvatar(
                radius: 19, backgroundImage: NetworkImage(item.profilePicUrl!)),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            item.memberName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
