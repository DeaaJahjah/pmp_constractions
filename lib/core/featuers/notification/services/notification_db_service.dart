import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_service.dart';

class NotificationDbService {
  final NotificationService _notificationService = NotificationService();
  var user = FirebaseAuth.instance.currentUser;
  int unReaded = 0;

  showNotification() {
    var collection = collectionName(user!.displayName!);
    FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .collection('notifications')
        .where('is_readed', isEqualTo: false)
        .snapshots()
        .listen((event) async {
      var docs = event.docs;

      for (var doc in docs) {
        var data = doc.data();
        if (data['is_readed'] == false) {
          await _notificationService.showNotifications(
              id: DateTime.now().millisecond,
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
        .snapshots(includeMetadataChanges: true);
  }

  addNotification(NotificationModle notificationModle) async {
    String? collection = collectionName(user!.displayName);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .collection('notifications')
        .add(notificationModle.toJson());
  }

  makeNotificationAsReaded() async {
    String? collection = collectionName(user!.displayName);
    var query = await FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .collection('notifications')
        .where('is_readed', isEqualTo: false)
        .get();
    List<NotificationModle> notification = [];
    for (var doc in query.docs) {
      var noti = NotificationModle.fromFirestore(doc);
      noti.isReaded = true;
      notification.add(noti);
    }
    for (var noti in notification) {
      FirebaseFirestore.instance
          .collection(collection)
          .doc(user!.uid)
          .collection('notifications')
          .doc(noti.notificationId)
          .update(noti.toJson());
    }
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
