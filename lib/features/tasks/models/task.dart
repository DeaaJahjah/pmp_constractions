import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/features/tasks/models/task_member.dart';

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
  List<TaskMember>? members;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.taskState,
      required this.startPoint,
      required this.endPoint,
      this.members});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  factory Task.fromFirestore(DocumentSnapshot documentSnapshot) {
    Task task = Task.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    task.id = documentSnapshot.id;
    return task;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, members];
}
