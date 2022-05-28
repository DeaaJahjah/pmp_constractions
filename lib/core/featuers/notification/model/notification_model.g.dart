// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModle _$NotificationModleFromJson(Map<String, dynamic> json) =>
    NotificationModle(
      title: json['title'] as String,
      body: json['body'] as String,
      isReaded: json['is_readed'] as bool,
      pauload: json['pauload'] as String,
      imageUrl: json['image_url'] as String,
      projectId: json['project_id'] as String?,
      taskId: json['task_id'] as String?,
      category: json['category'] as String,
    );

Map<String, dynamic> _$NotificationModleToJson(NotificationModle instance) =>
    <String, dynamic>{
      'notification_id': instance.notificationId,
      'title': instance.title,
      'body': instance.body,
      'is_readed': instance.isReaded,
      'project_id': instance.projectId,
      'task_id': instance.taskId,
      'pauload': instance.pauload,
      'image_url': instance.imageUrl,
      'category': instance.category,
    };
