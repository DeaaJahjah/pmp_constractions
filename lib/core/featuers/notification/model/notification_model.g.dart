// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModle _$NotificationModleFromJson(Map<String, dynamic> json) =>
    NotificationModle(
      notificationId: json['notification_id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      isReaded: json['is_readed'] as bool,
      pauload: json['pauload'] as String,
      imageUrl: json['image_url'] as String,
      projectId: json['project_id'] as String?,
      taskId: json['task_id'] as String?,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
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
      'type': _$NotificationTypeEnumMap[instance.type],
    };

const _$NotificationTypeEnumMap = {
  NotificationType.task: 'task',
  NotificationType.project: 'project',
  NotificationType.meeting: 'meeting',
  NotificationType.none: 'none',
};
