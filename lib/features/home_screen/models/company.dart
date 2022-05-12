import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable(explicitToJson: true)
class Company extends Equatable {
  //get it from document id
  @JsonKey(name: 'user_id')
  String? userId;
  final String name;
  final String description;
  @JsonKey(name: 'phone_numbers')
  final List<String>? phoneNumbers;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;

  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint location;

  Company(
      {this.userId,
      required this.name,
      required this.description,
      this.phoneNumbers,
      this.profilePicUrl,
      required this.location});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  factory Company.fromFirestore(DocumentSnapshot documentSnapshot) {
    Company company =
        Company.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    company.userId = documentSnapshot.id;
    return company;
  }

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  @override
  List<Object?> get props => [userId, name];
}
