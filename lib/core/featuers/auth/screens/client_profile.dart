import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custome_row.dart';
import 'package:pmpconstractions/core/widgets/elevated_button_custom.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/services/client_db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientProfile extends StatefulWidget {
  static const routeName = '/client_profile';
  String? clientId;
  ClientProfile({Key? key, this.clientId}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  var pref = SharedPreferences.getInstance();
  String? id;

  @override
  void initState() {
    pref.then((value) {
      setState(() {
        id = value.getString('uid');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Client>(
          future: ClientDbService().getClientById(widget.clientId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var client = snapshot.data!;
              return ListView(children: [
                SizedBox(
                  height: 225,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: const BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                    Positioned(
                        top: 15,
                        left: 7,
                        child: IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: darkBlue,
                            ),
                            onPressed: () {})),
                    const Positioned(
                      top: 20,
                      left: 135,
                      child: Text(
                        'My profile',
                        style: TextStyle(
                            color: darkBlue,
                            fontFamily: font,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: 78,
                      left: 107,
                      child: CircleAvatar(
                          backgroundColor: orange,
                          radius: 70,
                          child: (client.profilePicUrl != '')
                              ? CircleAvatar(
                                  backgroundColor: darkBlue,
                                  radius: 68,
                                  backgroundImage:
                                      NetworkImage(client.profilePicUrl ?? ''),
                                )
                              : const CircleAvatar(
                                  backgroundColor: darkBlue,
                                  radius: 68,
                                  backgroundImage:
                                      AssetImage('assets/images/prof.png'),
                                )),
                    ),
                  ]),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      client.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    sizedBoxLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButtonCustom(
                          text: 'Contact info',
                          onPressed: () {},
                          color: beg,
                          bgColor: beg,
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: beg,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                    ),
                    CustomeRow(icon: Icons.portrait, text: 'My project'),
                    const Divider(
                      thickness: 0.5,
                      color: beg,
                    ),
                    sizedBoxLarge,
                    Text(
                      'No projects Yet',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                )
              ]);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
