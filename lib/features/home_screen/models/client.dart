import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client extends Equatable {
  //get it from document id
  @JsonKey(name: 'user_id')
  String? userId;
  final String name;
  @JsonKey(name: 'phone_numbers')
  final List<String>? phoneNumbers;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;
  @JsonKey(name: 'projects_ids')
  final List<String> projectsIDs;

  Client(
      {this.userId,
      required this.name,
      this.phoneNumbers,
      this.profilePicUrl,
      required this.projectsIDs});

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  factory Client.fromFirestore(DocumentSnapshot documentSnapshot) {
    Client client =
        Client.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    client.userId = documentSnapshot.id;
    return client;
  }

  Map<String, dynamic> toJson() => _$ClientToJson(this);
  @override
  List<Object?> get props => [userId, name];
}
