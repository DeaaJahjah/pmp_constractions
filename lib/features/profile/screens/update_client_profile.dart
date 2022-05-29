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
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:path/path.dart' as path;
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:provider/provider.dart';

class UpdateClientProfileScreen extends StatefulWidget {
  Client client;
  UpdateClientProfileScreen({Key? key, required this.client}) : super(key: key);

  @override
  State<UpdateClientProfileScreen> createState() =>
      _UpdateClientProfileScreenState();
}

class _UpdateClientProfileScreenState extends State<UpdateClientProfileScreen> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  List<String> phoneNum = [];
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

  @override
  void initState() {
    nameController = TextEditingController(text: widget.client.name);
    phoneController = TextEditingController();
    phoneNum = widget.client.phoneNumbers!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    ? (widget.client.profilePicUrl == null)
                        ? const CircleAvatar(child: Icon(Icons.person_add))
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(widget.client.profilePicUrl!))
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
          Consumer<AuthSataProvider>(builder: (context, state, child) {
            if (state.authState == AuthState.notSet) {
              return ElevatedButton(
                  onPressed: () async {
                    if (nameController!.text != '') {
                      Provider.of<AuthSataProvider>(context, listen: false)
                          .changeAuthState(newState: AuthState.waiting);

                      String url = widget.client.profilePicUrl!;

                      if (imageFile != null) {
                        url = await FileService()
                            .uploadeimage(fileName, imageFile!, context);
                      }

                      ClientDbService().updateClient(
                          Client(
                              name: nameController!.text,
                              phoneNumbers: phoneNum,
                              profilePicUrl: url,
                              projectsIDs: widget.client.projectsIDs),
                          context);
                    } else {
                      const snackBar =
                          SnackBar(content: Text('The name is required'));
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
