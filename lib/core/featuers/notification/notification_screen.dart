import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        stream: NotificationProvider().getNotification(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                  title: Text(data['title']), subtitle: Text(data['body']));
            }).toList());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
