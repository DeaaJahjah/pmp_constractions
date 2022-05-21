import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/screens/watting_screen.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/core/widgets/number_text_field.dart';
import 'package:pmpconstractions/core/widgets/phone_card.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path/path.dart' as path;

class SetUpClientProfile extends StatefulWidget {
  static const routeName = '/aaaa';
  const SetUpClientProfile({Key? key}) : super(key: key);
  @override
  State<SetUpClientProfile> createState() => _SetUpClientProfileState();
}

int activePage = 0;

class _SetUpClientProfileState extends State<SetUpClientProfile> {
  final liquidController = LiquidController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  XFile? pickedimage;
  String name = '';
  List<String> phoneNum = [];
  String fileName = '';
  File imageFile = File('');
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

  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBlue,
        child: Column(children: [
          sizedBoxXLarge,
          Image.asset(
            'assets/images/setup_profile1.png',
            fit: BoxFit.fill,
          ),
          sizedBoxXLarge,
          InkWell(
            onTap: () {
              _pickImage();
              setState(() {});
              print(imageFile);
            },
            child: CircleAvatar(
                backgroundColor: karmedi,
                child: (pickedimage == null)
                    ? const Icon(Icons.person_add, size: 60, color: beg)
                    : CircleAvatar(
                        radius: 60, backgroundImage: FileImage(imageFile)),
                radius: 60),
          ),
          sizedBoxMedium,
          Text(context.loc.add_pic,
              style: Theme.of(context).textTheme.headlineMedium),
        ]),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBlue,
        child: ListView(children: [
          sizedBoxXLarge,
          Image.asset(
            'assets/images/setup_profile2.png',
            fit: BoxFit.fill,
          ),
          sizedBoxXLarge,
          sizedBoxMedium,
          TextFieldCustome(
            controller: nameController,
            text: context.loc.name,
          ),
          sizedBoxMedium,
        ]),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBlue,
        child: ListView(
          children: [
            sizedBoxXLarge,
            Image.asset(
              'assets/images/setup_profile2.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            sizedBoxMedium,
            NumberTextField(
              controller: phoneController,
              onPressed: () {
                if (phoneController.text != '' && phoneNum.length < 2) {
                  phoneNum.add(phoneController.text);
                  setState(() {
                    phoneController.text = '';
                  });
                }
              },
            ),
            sizedBoxMedium,
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => PhoneCard(
                    text: phoneNum[index],
                    onTap: () {
                      phoneNum.removeAt(index);
                      setState(() {});
                    },
                  ),
                  itemCount: phoneNum.length,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 140, right: 140),
              child: ElevatedButton(
                  onPressed: () async {
                    Provider.of<AuthSataProvider>(context, listen: false)
                        .changeAuthState(newState: AuthState.waiting);
                    String url = '';
                    if (imageFile != File('')) {
                      url = await FileService()
                          .uploadeimage(fileName, imageFile, context);
                    }
                    if (url != 'error') {
                      ClientDbService().addClient(
                          Client(
                              name: nameController.text,
                              phoneNumbers: phoneNum,
                              profilePicUrl: url),
                          context);
                    }
                  },
                  child: Text(
                    context.loc.done,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
            )
          ],
        ),
      )
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
                              ? Text(context.loc.back,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)
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

                            if (activePage + 1 < pages.length) {
                              liquidController.animateToPage(
                                  page: liquidController.currentPage + 1);
                            }
                            setState(() {});
                          },
                          child: (activePage != 2)
                              ? Text(context.loc.small_next,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)
                              : const SizedBox()),
                    ),
                  ],
                ),
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text(
                    context.loc.setup_profile,
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
