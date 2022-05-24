import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';

class ProjectDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Project>> getProjects() async {
    var queryData = await _db
        .collection('projects')
        .where('privacy', isEqualTo: ProjectPrivacy.public.name)
        .get();

    List<Project> projects = [];

    for (var doc in queryData.docs) {
      projects.add(Project.fromFirestore(doc));
    }

    return projects;
  }

  Future<List<Project>> getOpenProjects(List<String> projectsIDs) async {
    List<DocumentSnapshot<Map<String, dynamic>>> queryData = [];

    for (var docID in projectsIDs) {
      queryData.add(await _db.collection('projects').doc(docID).get());
    }

    List<Project> projects = [];

    for (var doc in queryData) {
      Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;
      if (cc['is_open'] == true) {
        projects.add(Project.fromFirestore(doc));
      }
    }
    return projects;
  }

  Future<List<Project>> getPublicProjects(List<String> projectsIDs) async {
    List<DocumentSnapshot<Map<String, dynamic>>> queryData = [];

    for (var docID in projectsIDs) {
      queryData.add(await _db.collection('projects').doc(docID.trim()).get());
    }

    List<Project> projects = [];

    for (var doc in queryData) {
      Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;
      if (cc['privacy'] == 'public') {
        projects.add(Project.fromFirestore(doc));
      }
    }
    return projects;
  }

  Future<Project> getProjectById(String id) async {
    var doc = await _db.collection('projects').doc(id).get();
    Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;

    return Project.fromJson(cc);
  }
}
