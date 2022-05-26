import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_service.dart';

class NotificationProvider {
  final NotificationService _notificationService = NotificationService();
  var user = FirebaseAuth.instance.currentUser;

  showNotification() {
    var collection = collectionName(user!.displayName!);
    FirebaseFirestore.instance
        .collection('engineers')
        .doc(user!.uid)
        .collection('notifications')
        .snapshots()
        .listen((event) async {
      var docs = event.docChanges;

      for (var doc in docs) {
        var data = doc.doc.data();
        print(data!['is_readed']);
        print(data['title']);
        if (data['is_readed'] == false) {
          return await _notificationService.showNotifications(
              title: data['title'],
              body: data['body'],
              pauload: '/notification');
        }
      }
    });
  }

  getNotification() {
    String? collection = collectionName(user!.displayName);
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .collection('notifications')
        .snapshots();

// .map((event) {
//          var docs= event.docs;
//          for (var doc in docs) {

//        ret   notifications.add( NotificationModle.fromFirestore(doc));
//          }
//         } );
  }

  addNotification(NotificationModle notificationModle) async {
    String? collection = collectionName(user!.displayName);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .collection('notifications')
        .add(notificationModle.toJson());
  }
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
