import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModle {
  //get it from document id
  @JsonKey(name: 'notification_id')
  String? notificationId;
  final String title;
  final String body;
  @JsonKey(name: 'is_readed')
  final bool isReaded;
  @JsonKey(name: 'project_id')
  final String? projectId;
  @JsonKey(name: 'task_id')
  final String? taskId;
  final String pauload;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String category;

  NotificationModle(
      {this.notificationId,
      required this.title,
      required this.body,
      required this.isReaded,
      required this.pauload,
      required this.imageUrl,
      this.projectId,
      this.taskId,
      required this.category});

  factory NotificationModle.fromJson(Map<String, dynamic> json) =>
      _$NotificationModleFromJson(json);

  factory NotificationModle.fromFirestore(DocumentSnapshot documentSnapshot) {
    NotificationModle notification = NotificationModle.fromJson(
        documentSnapshot.data() as Map<String, dynamic>);
    notification.notificationId = documentSnapshot.id;
    return notification;
  }

  Map<String, dynamic> toJson() => _$NotificationModleToJson(this);
}
