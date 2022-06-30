import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
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
    print(projectId);
    print(taskState.name);
    return _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .where('task_state', isEqualTo: taskState.name)
        .snapshots()
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
      await _db
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
              category: 'Task',
              projectId: project.projectId,
              taskId: task.id,
              imageUrl: project.imageUrl,
              isReaded: false,
              pauload: '/notification',
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

  //assign task

}
