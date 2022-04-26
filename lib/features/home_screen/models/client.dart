import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client extends Equatable {
  //get it from document id
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  @JsonKey(name: 'phone_numbers')
  final List<String>? phoneNumbers;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;

  const Client(
      {required this.userId,
      required this.name,
      this.phoneNumbers,
      this.profilePicUrl});

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
  @override
  List<Object?> get props => [userId];
}
