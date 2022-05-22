import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/services/company_db_service.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:path/path.dart' as path;
class SetUpCompanyProfile extends StatefulWidget {
  static const routeName = '/c';
  const SetUpCompanyProfile({Key? key}) : super(key: key);

  @override
  State<SetUpCompanyProfile> createState() => _SetUpCompanyProfileState();
}

int activePage = 0;

class _SetUpCompanyProfileState extends State<SetUpCompanyProfile> {
  final liquidController = LiquidController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
   var phoneController = TextEditingController();
    XFile? pickedimage;
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
    List<String> phoneNum = [];

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
                  radius: 60,                
                child: (pickedimage == null)?
                Icon(
                  Icons.person_add,
                  size: 50,
                  color: beg,
                ): CircleAvatar(
                        radius: 60,
                         backgroundImage: FileImage(imageFile),
               ),
              ),
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
          ],
        ),
      ),
      Container(
        color: darkBlue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Image.asset(
              'assets/images/setub_profile3.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: descController,
                maxLines: 4,
                decoration:  InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  label: Text(
                    context.loc.descripton,
                    style:Theme.of(context).textTheme.bodySmall
                  ),
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.start,
                autofocus: false,
              ),
            ),
          ],
        ),
      ),
      Container(
        color: darkBlue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          Image.asset(
            'assets/images/setup_profile4.png',
            fit: BoxFit.fill,
          ),
          sizedBoxXLarge,
          sizedBoxMedium,
          SizedBox(
            width: 300,
            height: 200,
            child: TextFormField(
              onTap: () {},
              decoration:  InputDecoration(
                isDense: true,
                label: Text(
                  context.loc.location,
                  style:Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
       
              ElevatedButton(
              onPressed: () async {
                Provider.of<AuthSataProvider>(context, listen: false)
                    .changeAuthState(newState: AuthState.waiting);

               
                String url = '';
                if (imageFile != File('')) {
                  url = await FileService()
                      .uploadeimage(fileName, imageFile, context);
                }
                if (url != 'error') {
                  CompanyDbService().addCompany(
                      Company(
                          name: nameController.text,
                          phoneNumbers: phoneNum,
                          profilePicUrl: url,
                          description: descController.text,
                          location: GeoPoint(12,20)
                          ),
                      context);
                  return;
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 140, right: 140),
                child: Text(
                  context.loc.done,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ))
        ]),
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
                    'Set up your profile',
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
