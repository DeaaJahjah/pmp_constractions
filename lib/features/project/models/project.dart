import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project extends Equatable {
  @JsonKey(name: 'project_id')
  String? projectId;
  final String name;
  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'company_id')
  final String companyId;
  final String description;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'modle_url')
  final String modelUrl;
  final ProjectPrivacy privacy;
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint location;
  final List<MemberRole>? members;

  Project(
      {this.projectId,
      required this.name,
      required this.companyName,
      required this.companyId,
      required this.description,
      required this.imageUrl,
      required this.modelUrl,
      required this.privacy,
      required this.isOpen,
      required this.location,
      this.members});

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  factory Project.fromFirestore(DocumentSnapshot documentSnapshot) {
    Project project =
        Project.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    project.projectId = documentSnapshot.id;
    return project;
  }

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  bool memberIn(String userId) {
    for (var member in members!) {
      if (member.memberId == userId) {
        return true;
      }
    }
    return false;
  }

  String getMemberName(String userId) {
    String name = '';
    for (var member in members!) {
      if (member.memberId == userId) {
        name = member.memberName;
      }
    }
    return name;
  }

  String getMemberImage(String userId) {
    String image = '';
    for (var member in members!) {
      if (member.memberId == userId) {
        image = member.memberName;
      }
    }

    return image;
  }

  bool hasPermissionToShowTask(String id) {
    for (var member in members!) {
      if (member.memberId == id && member.role != Role.client) {
        return true;
      }
    }
    return false;
  }

  bool hasPermissionToShowHistory(String id) {
    for (var member in members!) {
      if (member.memberId == id && member.role != Role.client) {
        return true;
      }
    }
    return false;
  }

  bool hasPermissionToStartMeeting(String id) {
    for (var member in members!) {
      if (member.memberId == id && member.role == Role.projectManager) {
        return true;
      }
    }
    return false;
  }

  bool hasPermessionToManageTask(String id) {
    for (var member in members!) {
      if (member.memberId == id &&
          (member.role == Role.projectManager ||
              member.role == Role.projectEngineer)) {
        return true;
      }
    }
    return false;
  }

  bool hasPermessionToJoinMeeting(String id) {
    for (var member in members!) {
      if (member.memberId == id && member.role != Role.client) {
        return true;
      }
    }
    return false;
  }

  @override
  List<Object?> get props => [projectId, name, members];
}

@JsonSerializable(explicitToJson: true)
class MemberRole extends Equatable {
  @JsonKey(name: 'member_id')
  final String memberId;
  @JsonKey(name: 'member_name')
  final String memberName;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;
  @JsonKey(name: 'collection_name')
  String? collectionName;
  Role? role;
  bool submited;

  MemberRole(
      {required this.memberId,
      required this.memberName,
      required this.profilePicUrl,
      required this.submited,
      this.role,
      this.collectionName});

  factory MemberRole.fromJson(Map<String, dynamic> json) =>
      _$MemberRoleFromJson(json);

  Map<String, dynamic> toJson() => _$MemberRoleToJson(this);

  @override
  List<Object?> get props =>
      [memberId, role, collectionName, memberName, profilePicUrl, submited];
}
