// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      userId: json['user_id'] as String?,
      name: json['name'] as String,
      phoneNumbers: (json['phone_numbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profilePicUrl: json['profile_pic_url'] as String?,
      projectsIDs: (json['projects_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'phone_numbers': instance.phoneNumbers,
      'profile_pic_url': instance.profilePicUrl,
      'projects_ids': instance.projectsIDs,
    };
