// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      modelUrl: json['modle_url'] as String,
      privacy: json['privacy'] as bool,
      isOpen: json['is_open'] as bool,
      location: Project._fromJsonGeoPoint(json['location'] as GeoPoint),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => MemberRole.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'modle_url': instance.modelUrl,
      'privacy': instance.privacy,
      'is_open': instance.isOpen,
      'location': Project._toJsonGeoPoint(instance.location),
      'members': instance.members?.map((e) => e.toJson()).toList(),
    };

MemberRole _$MemberRoleFromJson(Map<String, dynamic> json) => MemberRole(
      memberId: json['member_id'] as String,
      memberName: json['member_name'] as String,
      profilePicUrl: json['profile_pic_url'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$MemberRoleToJson(MemberRole instance) =>
    <String, dynamic>{
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'profile_pic_url': instance.profilePicUrl,
      'role': _$RoleEnumMap[instance.role],
    };

const _$RoleEnumMap = {
  Role.projectManager: 'projectManager',
  Role.projectEngineer: 'projectEngineer',
  Role.siteEngineer: 'siteEngineer',
  Role.client: 'client',
};
