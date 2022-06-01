import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:pmpconstractions/core/widgets/number_text_field.dart';
import 'package:pmpconstractions/core/widgets/phone_card.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:path/path.dart' as path;
import 'package:pmpconstractions/features/home_screen/services/engineer_db_service.dart';
import 'package:provider/provider.dart';

class UpdateEngineerProfileScreen extends StatefulWidget {
  Engineer engineer;
  UpdateEngineerProfileScreen({Key? key, required this.engineer})
      : super(key: key);

  @override
  State<UpdateEngineerProfileScreen> createState() =>
      _UpdateEngineerProfileScreenState();
}

class _UpdateEngineerProfileScreenState
    extends State<UpdateEngineerProfileScreen> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  var languageController;
  var certificateController;
  var programController;
  Map<String, List<String>>? experiens;
  List<String> phoneNum = [];
  String specialization = 'Select';
  List<String> items = [
    'Select',
    'Architectural engineer',
    'Civil engineer',
    'Elctricity  engineer',
    'Water  engineer',
  ];

  String fileName = '';
  File? imageFile;
  XFile? pickedimage;
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

  String removeComan(List<String>? list) {
    String value = '';
    if (list != null) {
      for (int i = 0; i < list.length; i++) {
        if (i == list.length - 1) {
          value += list[i];
          break;
        }
        value += list[i] + ',';
      }
    }

    return value;
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.engineer.name);
    phoneController = TextEditingController();
    programController = TextEditingController(
        text: removeComan(widget.engineer.experience!['programs']));
    languageController = TextEditingController(
        text: removeComan(widget.engineer.experience!['languages']));
    certificateController = TextEditingController(
        text: removeComan(widget.engineer.experience!['certificates']));
    phoneNum = widget.engineer.phoneNumbers!;
    specialization = widget.engineer.specialization;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(specialization);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your data'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          InkWell(
            onTap: () {
              _pickImage();
              setState(() {});
            },
            child: CircleAvatar(
                backgroundColor: karmedi,
                child: (pickedimage == null)
                    ? (widget.engineer.profilePicUrl == null)
                        ? const CircleAvatar(child: Icon(Icons.person_add))
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(widget.engineer.profilePicUrl!))
                    : CircleAvatar(
                        radius: 60, backgroundImage: FileImage(imageFile!)),
                radius: 60),
          ),
          sizedBoxMedium,
          const SizedBox(
            height: 40,
          ),
          TextFieldCustome(text: 'Name', controller: nameController!),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
                height: 40,
                child: FormField<String>(
                    initialValue: 'Select',
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
                            value: specialization,
                            isDense: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                specialization = newValue!;
                              });
                            },
                            items: items.map((String item) {
                              //print(item);
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    })),
          ),
          sizedBoxMedium,
          sizedBoxMedium,
          Padding(
            padding: const EdgeInsets.only(right: 85),
            child: NumberTextField(
              controller: phoneController!,
              onPressed: () {
                if (phoneController!.text != '' && phoneNum.length < 2) {
                  phoneNum.add(phoneController!.text);
                  setState(() {
                    phoneController!.text = '';
                  });
                }
              },
            ),
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
          TextFieldCustome(text: 'Programs', controller: programController!),
          const SizedBox(
            height: 40,
          ),
          TextFieldCustome(text: 'Languages', controller: languageController!),
          const SizedBox(
            height: 40,
          ),
          TextFieldCustome(
              text: 'Certificates', controller: certificateController!),
          const SizedBox(
            height: 40,
          ),
          Consumer<AuthSataProvider>(builder: (context, state, child) {
            if (state.authState == AuthState.notSet) {
              return ElevatedButton(
                  onPressed: () async {
                    if (nameController!.text != '' &&
                        specialization != 'Select') {
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

                      String url = widget.engineer.profilePicUrl!;

                      if (imageFile != null) {
                        url = await FileService()
                            .uploadeimage(fileName, imageFile!, context);
                      }

                      EngineerDbService().updateEngineer(
                          Engineer(
                              name: nameController!.text,
                              phoneNumbers: phoneNum,
                              profilePicUrl: url,
                              specialization: specialization,
                              experience: experiens,
                              projectsIDs: widget.engineer.projectsIDs),
                          context);
                    } else {
                      const snackBar =
                          SnackBar(content: Text('some fields are required'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(context.loc.update));
            }
            if (state.authState == AuthState.waiting) {
              return const CircularProgressIndicator();
            }
            return const SizedBox();
          })
        ]),
      ),
    );
  }
}
