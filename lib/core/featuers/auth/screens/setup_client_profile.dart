import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path/path.dart' as path;

class SetUpClientProfile extends StatefulWidget {
  static const routeName = '/client_set_up';
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
                    : Image.file(imageFile),
                maxRadius: 60),
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
      SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBlue,
        child: Column(children: [
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
      )),
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: darkBlue,
          child: Column(
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
                          if (phoneController.text != '') {
                            phoneNum.add(phoneController.text);
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
                  )
                ],
              ),
              sizedBoxMedium,
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
        ),
      ),
    ];

    return Scaffold(
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
                  Positioned(
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
                    bottom: -7,
                    left: 300,
                  ),
                  Positioned(
                      bottom: 12,
                      left: 150,
                      child: AnimatedSmoothIndicator(
                        activeIndex: activePage,
                        count: pages.length,
                        duration: const Duration(milliseconds: 300),
                        effect: const WormEffect(
                          activeDotColor: orange,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      )),
                ],
              ))),
    );
  }
}
