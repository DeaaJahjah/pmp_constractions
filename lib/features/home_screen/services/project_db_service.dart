import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';

class ProjectDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Project>> getProjects() async {
    var queryData = await _db.collection('projects').get();
    List<Project> projects = [];
    for (var doc in queryData.docs) {
      var project = Project.fromJson(doc.data());
      project.projectId = doc.id;
      projects.add(project);
    }

    return projects;
  }

  Future<Project> getProjectById(String id) async {
    var doc = await _db.collection('projects').doc(id).get();
    Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;

    return Project.fromJson(cc);
  }
}
