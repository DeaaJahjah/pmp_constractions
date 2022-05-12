// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      name: json['name'] as String,
      phoneNumbers: (json['phone_numbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profilePicUrl: json['profile_pic_url'] as String?,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'name': instance.name,
      'phone_numbers': instance.phoneNumbers,
      'profile_pic_url': instance.profilePicUrl,
    };
