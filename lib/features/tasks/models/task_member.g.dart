// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskMember _$TaskMemberFromJson(Map<String, dynamic> json) => TaskMember(
      memberId: json['member_id'] as String,
      memberName: json['member_name'] as String,
      profilePicUrl: json['profile_pic_url'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      submited: json['submited'] as bool,
    );

Map<String, dynamic> _$TaskMemberToJson(TaskMember instance) =>
    <String, dynamic>{
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'profile_pic_url': instance.profilePicUrl,
      'role': _$RoleEnumMap[instance.role],
      'submited': instance.submited,
    };

const _$RoleEnumMap = {
  Role.projectManager: 'projectManager',
  Role.projectEngineer: 'projectEngineer',
  Role.siteEngineer: 'siteEngineer',
  Role.client: 'client',
  Role.company: 'company',
};
