import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmpconstractions/features/project/models/history.dart';

class HistoryDbServices {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<History>> getHistory(String projectId) async {
    List<History> hestories = [];
    var data = await db
        .collection('projects')
        .doc(projectId)
        .collection('history')
        .orderBy('date', descending: true)
        .get();
    for (var doc in data.docs) {
      hestories.add(History.fromFirestore(doc));
    }
    return hestories;
  }

  Future<void> addHistory(String projectId, History history) async {
    await db
        .collection('projects')
        .doc(projectId)
        .collection('history')
        .add(history.toJson());
  }
}
