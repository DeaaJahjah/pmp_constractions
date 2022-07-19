// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      taskState: $enumDecode(_$TaskStateEnumMap, json['task_state']),
      startPoint: DateTime.parse(json['start_point'] as String),
      endPoint: DateTime.parse(json['end_oint'] as String),
      attchmentUrl: json['attchmentUrl'] as String,
      checkByManager: json['checkByManager'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => MemberRole.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'task_state': _$TaskStateEnumMap[instance.taskState],
      'start_point': instance.startPoint.toIso8601String(),
      'end_oint': instance.endPoint.toIso8601String(),
      'attchmentUrl': instance.attchmentUrl,
      'checkByManager': instance.checkByManager,
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$TaskStateEnumMap = {
  TaskState.notStarted: 'notStarted',
  TaskState.inProgress: 'inProgress',
  TaskState.completed: 'completed',
};
