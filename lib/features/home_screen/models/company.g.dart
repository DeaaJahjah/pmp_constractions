// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      userId: json['user_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      phoneNumbers: (json['phone_numbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profilePicUrl: json['profile_pic_url'] as String?,
      location: Company._fromJsonGeoPoint(json['location'] as GeoPoint),
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'phone_numbers': instance.phoneNumbers,
      'profile_pic_url': instance.profilePicUrl,
      'location': Company._toJsonGeoPoint(instance.location),
    };
