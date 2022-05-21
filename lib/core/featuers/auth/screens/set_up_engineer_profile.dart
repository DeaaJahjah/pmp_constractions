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
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:path/path.dart' as path;

class SetUpEngineerProfile extends StatefulWidget {
  static const routeName = '/va';
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
                    : CircleAvatar(
                        radius: 60, backgroundImage: FileImage(imageFile)),
                maxRadius: 60),
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
        child: ListView(children: [
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
          TextFieldCustome(
              text: context.loc.languages, controller: languageController),
          sizedBoxLarge,
          TextFieldCustome(
              text: context.loc.certificate, controller: certificateController),
          sizedBoxLarge,
          TextFieldCustome(
              text: context.loc.programs, controller: programController),
          ElevatedButton(
              onPressed: () async {
                Provider.of<AuthSataProvider>(context, listen: false)
                    .changeAuthState(newState: AuthState.waiting);

                var languages = languageController.text.split(',');
                var certificates = certificateController.text.split(',');
                var programs = programController.text.split(',');

                experiens = {
                  'languages': languages,
                  'certificates': certificates,
                  'programs': programs
                };
                String url = '';
                if (imageFile != File('')) {
                  url = await FileService()
                      .uploadeimage(fileName, imageFile, context);
                }
                if (url != 'error') {
                  EngineerDbService().addEngineer(
                      Engineer(
                          name: nameController.text,
                          specialization: specialization,
                          experience: experiens,
                          phoneNumbers: phoneNum,
                          profilePicUrl: url),
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
                    )),
              ),
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
                          if (activePage == 1 && nameController.text.isEmpty) {
                            const snackBar =
                                SnackBar(content: Text('The name is required'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          if (activePage == 3 && specialization.isNotEmpty) {
                            liquidController.animateToPage(
                                page: liquidController.currentPage + 1);
                            setState(() {});
                            return;
                          }
                          if (activePage == 3 && specialization.isEmpty) {
                            const snackBar = SnackBar(
                                content:
                                    Text('The specialization is required'));
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
                            ? Text(context.loc.small_next,
                                style:
                                    Theme.of(context).textTheme.headlineSmall)
                            : const SizedBox()),
                  ),
                ],
              ),
            ),
    );
  }
}
