import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path/path.dart' as path;

class SetUpEngineerProfile extends StatefulWidget {
  static const routeName = '/engineer_set_up';
  const SetUpEngineerProfile({Key? key}) : super(key: key);

  @override
  State<SetUpEngineerProfile> createState() => _SetUpEngineerProfileState();
}

int activePage = 0;

class _SetUpEngineerProfileState extends State<SetUpEngineerProfile> {
  final liquidController = LiquidController();
  var phoneController = TextEditingController();
  var languageController = TextEditingController();
  var certificateController = TextEditingController();
  var programController = TextEditingController();
  final nameController = TextEditingController();
  XFile? pickedimage;
  String name = '';
  List<String> phoneNum = [];
  Map<String, List<String>>? experiens;
  String specialization = '';
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

  String dropdownvalue = 'Architectural engineer';
  var items = [
    'Architectural engineer',
    'Civil engineer',
    'Elctricity  engineer',
    'Water  engineer',
  ];
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
                              color: orange,
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
              )
            ],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          color: darkBlue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Image.asset(
              'assets/images/setub_profile3.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            SizedBox(
              width: 250,
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 4,
                            borderRadius: BorderRadius.circular(5.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: beg,
                        elevation: 10,
                        iconEnabledColor: orange,
                        style: const TextStyle(
                            color: orange,
                            fontFamily: font,
                            fontWeight: FontWeight.bold),
                        alignment: AlignmentDirectional.center,
                        focusColor: orange,
                        value: dropdownvalue,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            specialization = newValue;
                          });
                        },
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          color: darkBlue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Image.asset(
              'assets/images/setup_profile4.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            SizedBox(
              width: 260,
              height: 40,
              child: TextFormField(
                controller: languageController,
                decoration: const InputDecoration(
                  prefixStyle: TextStyle(
                      color: beg,
                      fontFamily: font,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  label: Text(
                    'Languages',
                    style: TextStyle(
                        color: orange,
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
            sizedBoxLarge,
            SizedBox(
              width: 260,
              child: TextFormField(
                controller: certificateController,
                decoration: const InputDecoration(
                  hintMaxLines: 3,
                  prefixStyle: TextStyle(
                      color: beg,
                      fontFamily: font,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  label: Text(
                    'Certificates',
                    style: TextStyle(
                        color: orange,
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
            sizedBoxLarge,
            SizedBox(
              width: 260,
              height: 40,
              child: TextFormField(
                controller: programController,
                decoration: const InputDecoration(
                  prefixStyle: TextStyle(
                      color: beg,
                      fontFamily: font,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  label: Text(
                    'Programs',
                    style: TextStyle(
                        color: orange,
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
            ElevatedButton(
                onPressed: () async {
                  var languages = languageController.text.split(',');
                  var certificates = certificateController.text.split(',');
                  var programs = programController.text.split(',');
                  experiens = {
                    'languages': languages,
                    'certificates': certificates,
                    'programs': programs
                  };
                  print(languages.length);
                  print(fileName);
                  print(phoneNum.length);
                  String url =
                      await FileService().uploadeimage(fileName, imageFile);
                  EngineerDbService().addEngineer(
                      Engineer(
                          name: nameController.text,
                          specialization: specialization,
                          experience: experiens,
                          phoneNumbers: phoneNum,
                          profilePicUrl: url),
                      context);
                },
                child: const Text('DONE'))
          ]),
        ),
      )
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
                        count: pages.length,
                        activeIndex: activePage,
                        duration: const Duration(milliseconds: 300),
                        effect: const WormEffect(
                            activeDotColor: orange,
                            dotHeight: 10,
                            dotWidth: 10),
                      ))
                ],
              ))),
    );
  }
}
