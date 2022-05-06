import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';

class ProjectDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Engineer>> getEngineers() async {
    var queryData = await _db.collection('engineers').get();
    List<Engineer> engineers = [];

    for (var doc in queryData.docs) {
      engineers.add(Engineer.fromFirestore(doc));
    }

    return engineers;
  }

  Future<Engineer> getEngineerById(String id) async {
    var doc = await _db.collection('engineers').doc(id).get();
    Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;

    return Engineer.fromJson(cc);
  }
}
