// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      projectId: json['project_id'] as String?,
      name: json['name'] as String,
      companyName: json['company_name'] as String,
      companyId: json['company_id'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      modelUrl: json['modle_url'] as String,
      privacy: $enumDecode(_$ProjectPrivacyEnumMap, json['privacy']),
      isOpen: json['is_open'] as bool,
      location: Project._fromJsonGeoPoint(json['location'] as GeoPoint),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => MemberRole.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'project_id': instance.projectId,
      'name': instance.name,
      'company_name': instance.companyName,
      'company_id': instance.companyId,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'modle_url': instance.modelUrl,
      'privacy': _$ProjectPrivacyEnumMap[instance.privacy],
      'is_open': instance.isOpen,
      'location': Project._toJsonGeoPoint(instance.location),
      'members': instance.members?.map((e) => e.toJson()).toList(),
    };

const _$ProjectPrivacyEnumMap = {
  ProjectPrivacy.private: 'private',
  ProjectPrivacy.public: 'public',
};

MemberRole _$MemberRoleFromJson(Map<String, dynamic> json) => MemberRole(
      memberId: json['member_id'] as String,
      memberName: json['member_name'] as String,
      profilePicUrl: json['profile_pic_url'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      collectionName: json['collection_name'],
    );

Map<String, dynamic> _$MemberRoleToJson(MemberRole instance) =>
    <String, dynamic>{
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'profile_pic_url': instance.profilePicUrl,
      'user_type': instance.collectionName,
      'role': _$RoleEnumMap[instance.role],
    };

const _$RoleEnumMap = {
  Role.projectManager: 'projectManager',
  Role.projectEngineer: 'projectEngineer',
  Role.siteEngineer: 'siteEngineer',
  Role.client: 'client',
};

const _$UserTypeEnumMap = {
  UserType.engineer: 'engineer',
  UserType.company: 'company',
  UserType.client: 'client',
};
