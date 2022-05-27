import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: NotificationDbService().getNotification(),
        builder: (context, snapshot) {
          print('streaam');
          if (snapshot.hasData) {
            print('has dataaa');
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: orange),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data['image_url']),
                    ),
                    title: Text(data['title'],
                        style: Theme.of(context).textTheme.headlineMedium),
                    subtitle: Text(
                      data['body'],
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
              );
            }).toList());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
