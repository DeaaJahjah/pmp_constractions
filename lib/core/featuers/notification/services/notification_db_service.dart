import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_service.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';

class NotificationDbService {
  final NotificationService _notificationService = NotificationService();
  var user = FirebaseAuth.instance.currentUser;
  int unReaded = 0;

  Future<void> sendNotification(
      {required MemberRole member,
      required NotificationModle notification}) async {
    await FirebaseFirestore.instance
        .collection(member.collectionName!)
        .doc(member.memberId)
        .collection('notifications')
        .add(notification.toJson());
  }

  showNotification() {
    var collection = collectionName(user?.displayName!);
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
        await _notificationService.showNotifications(
            id: DateTime.now().millisecond,
            title: data['title'],
            body: data['body'],
            pauload: '/notification');
      }
    });
  }

  // getNotification() {
  //   String? collection = collectionName(user!.displayName);

  //   return FirebaseFirestore.instance
  //       .collection(collection)
  //       .doc(user!.uid)
  //       .collection('notifications')
  //       .snapshots(includeMetadataChanges: true);
  // }

  //get notification real time

  Stream<List<NotificationModle>> getNotifications() {
    String? collection = collectionName(user!.displayName);
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .collection('notifications')
        .snapshots()
        .map(_projectListFromSnapshot);
  }

  List<NotificationModle> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return NotificationModle.fromFirestore(doc);
    }).toList();
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
