import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:pmpconstractions/features/project/models/history.dart';
import 'package:pmpconstractions/features/project/models/project.dart';
import 'package:pmpconstractions/features/project/services/history_db_service.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';

class TasksDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Task> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Task.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Task>> getTasks(
      {required String projectId, required TaskState taskState}) {
    return _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .where('task_state', isEqualTo: taskState.name)
        .orderBy('created_at', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map(_projectListFromSnapshot);
  }

  //get task by id real time
  Stream<Task> getTaskById(
      {required String projectId, required String taskId}) {
    return _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .snapshots()
        .map((doc) => Task.fromFirestore(doc));
  }

  //add task
  Future<bool> addTask(
      {required Project project,
      required Task task,
      required BuildContext context}) async {
    try {
      var taskId = await _db
          .collection('projects')
          .doc(project.projectId)
          .collection('tasks')
          .add(task.toJson());

      //send [Added to project] notification fpr all members
      for (MemberRole member in task.members ?? []) {
        await NotificationDbService().sendNotification(
            member: member,
            notification: NotificationModle(
              title: project.name,
              body: '${task.title} ,Assigned to you',
              type: NotificationType.task,
              projectId: project.projectId,
              taskId: taskId.id,
              imageUrl: project.imageUrl,
              isReaded: false,
              pauload: '/notification',
              createdAt: DateTime.now(),
            ));
      }
    } on FirebaseException catch (e) {
      print(e);
      showErrorSnackBar(context, e.message!);
      return false;
    }
    return true;
  }

  //delete task
  Future<void> deleteTask(
      {required String projectId, required String taskId}) async {
    await _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  //update task
  Future<void> updateTask(
      {required String projectId, required Task task}) async {
    await _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(task.id)
        .update(task.toJson());
  }

  //update task state
  Future<void> updateTaskState(
      {required String projectId,
      required String taskId,
      required TaskState taskState}) async {
    await _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .update({'task_state': taskState.name});
  }

  //assigned task to member
  Future<void> assignedTaskToMember(
      {required Project project,
      required Task task,
      required List<MemberRole> newMember,
      required BuildContext context}) async {
    task.members!.addAll(newMember);

    await updateTask(projectId: project.projectId!, task: task);

    for (MemberRole member in newMember) {
      await NotificationDbService().sendNotification(
          member: member,
          notification: NotificationModle(
            title: project.name,
            body: '${task.title} , Assigned to you',
            type: NotificationType.task,
            projectId: project.projectId,
            taskId: task.id,
            imageUrl: project.imageUrl,
            isReaded: false,
            pauload: '/notification',
            createdAt: DateTime.now(),
          ));

      var name = project.getMemberName(context.userUid!);
      var imageUrl = project.getMemberImage(context.userUid!);

      await HistoryDbServices().addHistory(
          project.projectId!,
          History(
              contant:
                  '$name assigned the task ${task.title} to ${member.memberName},',
              date: DateTime.now(),
              imageUrl: imageUrl));
    }
  }
}
