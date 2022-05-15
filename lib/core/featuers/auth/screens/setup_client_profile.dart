import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/core/widgets/phone_card.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path/path.dart' as path;

class SetUpClientProfile extends StatefulWidget {
  static const routeName = '/';
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
                    ? const Icon(Icons.person, size: 60, color: beg)
                    : CircleAvatar(
                        radius: 60, backgroundImage: FileImage(imageFile)),
                radius: 60),
          ),
          sizedBoxMedium,
          const Text('Add a picture',
              style: TextStyle(
                color: beg,
                fontFamily: font,
                fontSize: 24,
              )),
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
            text: 'Name',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 230,
                  height: 40,
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(14),
                      label: Text(
                        'Number',
                        style: TextStyle(
                            color: beg,
                            fontFamily: font,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                      alignLabelWithHint: true,
                    ),
                    textAlign: TextAlign.start,
                    autofocus: false,
                    style: const TextStyle(
                        color: beg,
                        fontFamily: font,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: IconButton(
                      onPressed: () {
                        if (phoneController.text != '' && phoneNum.length < 2) {
                          phoneNum.add(phoneController.text);
                          setState(() {
                            phoneController.text = '';
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 15,
                        color: beg,
                      )),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
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
            ElevatedButton(
                onPressed: () async {
                  print(fileName);
                  print(phoneNum.length);
                  String url =
                      await FileService().uploadeimage(fileName, imageFile);
                  ClientDbService().addClient(
                      Client(
                          name: nameController.text,
                          phoneNumbers: phoneNum,
                          profilePicUrl: url),
                      context);
                },
                child: const Text('DONE'))
          ],
        ),
      )
    ];

    return Scaffold(
      bottomNavigationBar: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
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
                if (activePage + 1 < pages.length) {
                  liquidController.jumpToPage(
                      page: liquidController.currentPage + 1);
                }
                setState(() {});
              },
              child: const Text('Skip',
                  style: TextStyle(
                    color: beg,
                    fontFamily: font,
                    fontWeight: FontWeight.bold,
                  )),
            ),
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
                    pages: pages,
                    liquidController: liquidController,
                    onPageChangeCallback: (index) {
                      activePage = index;
                      setState(() {});
                    },
                  ),
                ],
              ))),
    );
  }
}
