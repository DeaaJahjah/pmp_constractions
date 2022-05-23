// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Engineer _$EngineerFromJson(Map<String, dynamic> json) => Engineer(
      userId: json['user_id'] as String?,
      name: json['name'] as String,
      phoneNumbers: (json['phone_numbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profilePicUrl: json['profile_pic_url'] as String?,
      specialization: json['specialization'] as String,
      experience: (json['experience'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      projectsIDs: (json['projects_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EngineerToJson(Engineer instance) => <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'phone_numbers': instance.phoneNumbers,
      'profile_pic_url': instance.profilePicUrl,
      'specialization': instance.specialization,
      'experience': instance.experience,
      'projects_ids': instance.projectsIDs,
    };
