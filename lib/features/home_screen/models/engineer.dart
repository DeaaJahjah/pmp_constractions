import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'engineer.g.dart';

@JsonSerializable()
class Engineer extends Equatable {
  //get it from document id
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  @JsonKey(name: 'phone_numbers')
  final List<String>? phoneNumbers;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;
  final String specialization;
  final Map<String, List<String>>? experience;

  const Engineer(
      {required this.userId,
      required this.name,
      this.phoneNumbers,
      this.profilePicUrl,
      required this.specialization,
      required this.experience});

  factory Engineer.fromJson(Map<String, dynamic> json) =>
      _$EngineerFromJson(json);

  Map<String, dynamic> toJson() => _$EngineerToJson(this);

  @override
  List<Object?> get props => [userId];
}
