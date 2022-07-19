import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task extends Equatable {
  String? id;
  final String title;
  final String description;
  @JsonKey(name: 'task_state')
  final TaskState taskState;
  @JsonKey(name: 'start_point')
  final DateTime startPoint;
  @JsonKey(name: 'end_oint')
  final DateTime endPoint;
  final String attchmentUrl;
  final bool checkByManager;
  List<MemberRole>? members;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.taskState,
      required this.startPoint,
      required this.endPoint,
      required this.attchmentUrl,
      required this.checkByManager,
      required this.createdAt,
      this.members});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  factory Task.fromFirestore(DocumentSnapshot documentSnapshot) {
    Task task = Task.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    task.id = documentSnapshot.id;
    return task;
  }

  getProgressValue() {
    int submitedMembers = 0;
    for (var member in members!) {
      if (member.submited) {
        submitedMembers++;
      }
    }
    return submitedMembers / members!.length;
  }

  getStartPoint() {
    return "${startPoint.day}-${startPoint.month}-${startPoint.year}";
  }

  getEndPoint() {
    return "${endPoint.day}-${endPoint.month}-${endPoint.year}";
  }

  getTaskDays() {
    return endPoint.difference(startPoint).inDays;
  }

  bool allMembersSubmited() {
    int submitedMembers = 0;
    for (var member in members!) {
      if (member.submited) {
        submitedMembers++;
      }
    }
    if (submitedMembers == members!.length) {
      return true;
    }
    return false;
  }

  submited(String memberId) {
    for (var member in members!) {
      if (member.memberId == memberId && member.submited) {
        return true;
      }
    }
    return false;
  }

  @override
  List<Object?> get props => [id, members];
}
