import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'engineer.g.dart';

@JsonSerializable()
class Engineer extends Equatable {
  //get it from document id
  @JsonKey(name: 'user_id')
  String? userId;
  final String name;
  @JsonKey(name: 'phone_numbers')
  final List<String>? phoneNumbers;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;
  final String specialization;
  final Map<String, List<String>>? experience;
  @JsonKey(name: 'projects_ids')
  final List<String> projectsIDs;

  Engineer(
      {this.userId,
      required this.name,
      this.phoneNumbers,
      this.profilePicUrl,
      required this.specialization,
      required this.experience,
      required this.projectsIDs});

  factory Engineer.fromJson(Map<String, dynamic> json) =>
      _$EngineerFromJson(json);

  factory Engineer.fromFirestore(DocumentSnapshot documentSnapshot) {
    Engineer engineer =
        Engineer.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    engineer.userId = documentSnapshot.id;
    return engineer;
  }

  Map<String, dynamic> toJson() => _$EngineerToJson(this);

  @override
  List<Object?> get props => [userId];
}
