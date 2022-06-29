import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
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
        .snapshots()
        .map(_projectListFromSnapshot);
  }

  //add task
  Future<void> addTask({required String projectId, required Task task}) async {
    await _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .add(task.toJson());
  }
}
