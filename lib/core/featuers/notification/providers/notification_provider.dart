import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  int count = 0;

  unreadedNotidicationLength() {
    return count;
  }

  showNotification() async {
    var user = FirebaseAuth.instance.currentUser;
    var collection = collectionName(user!.displayName!);
    var s = FirebaseFirestore.instance
        .collection('engineers')
        .doc(user.uid)
        .collection('notifications')
        .where('is_readed', isEqualTo: false)
        .snapshots()
        .listen((event) {
      count = event.docs.length;

      notifyListeners();
    });

    //   ((event) async {
    // var docs = event.docs;

    // for (var doc in docs) {
    //   var data = doc.data();

    //   if (data['is_readed'] == false) {
    //     if (count < docs.length) {
    //       count += 1;
    //     }
    //   }
    // }
  }

  String collectionName(String? type) {
    switch (type) {
      case 'engineer':
        return 'engineers';

      case 'client':
        return 'clients';
      case 'company':
        return 'companies';
    }
    return '';
  }
}
