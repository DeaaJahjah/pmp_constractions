import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';

part 'task_member.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskMember extends Equatable {
  @JsonKey(name: 'member_id')
  final String memberId;
  @JsonKey(name: 'member_name')
  final String memberName;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;
  Role? role;
  bool submited;

  factory TaskMember.fromJson(Map<String, dynamic> json) =>
      _$TaskMemberFromJson(json);

  TaskMember(
      {required this.memberId,
      required this.memberName,
      this.profilePicUrl,
      required this.role,
      required this.submited});
  Map<String, dynamic> toJson() => _$TaskMemberToJson(this);

  @override
  List<Object> get props => [submited, memberId, role!];
}
