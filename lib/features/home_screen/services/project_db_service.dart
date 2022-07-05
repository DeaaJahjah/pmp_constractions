import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:provider/provider.dart';

class ProjectDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  createProject(Project project, context, String profilePicUrl) async {
    try {
      final projectDoc = await _db.collection('projects').add(project.toJson());

      for (MemberRole member in project.members ?? []) {
        // add project id to all members
        _db.collection(member.collectionName!).doc(member.memberId).update(
          {
            'projects_ids': FieldValue.arrayUnion([projectDoc.id])
          },
        );
        //send [Added to project] notification fpr all members
        String role = member.role!.name;
        await NotificationDbService().sendNotification(
            member: member,
            notification: NotificationModle(
              title: project.name,
              body: '${project.companyName} added you as a $role',
              type: NotificationType.none,
              imageUrl: profilePicUrl,
              projectId: projectDoc.id,
              isReaded: false,
              pauload: '/notification',
            ));
      }

      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
      const snackBar = SnackBar(
        content: Text('Project created successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // refresh the data
      Provider.of<DataProvider>(context, listen: false).fetchProjects();
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      print(e);

      //TODO -- impliment error snackbar
    }
  }

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

  //get project realtime updates
  Stream<Project> getProjectUpdates(String id) {
    return _db.collection('projects').doc(id).snapshots().map((doc) {
      return Project.fromFirestore(doc);
    });
  }

  Future<List<Project>> geCompanyOpenProjects(String uid) async {
    List<Project> projects = [];

    var query = await _db
        .collection('projects')
        .where('company_id', isEqualTo: uid)
        .where('is_open', isEqualTo: true)
        .get();

    for (var doc in query.docs) {
      projects.add(Project.fromFirestore(doc));
    }

    return projects;
  }

  // show the copmpany projects
  Future<List<Project>> geCompanyProjects(String companyId) async {
    List<Project> projects = [];

    var query = await _db
        .collection('projects')
        .where('company_id', isEqualTo: companyId)
        .get();

    for (var doc in query.docs) {
      projects.add(Project.fromFirestore(doc));
    }
    print(projects.length);
    return projects;
  }

  // for any one vist the company profile
  Future<List<Project>> geCompanyPublicProjects(String companyId) async {
    List<Project> projects = [];

    var query = await _db
        .collection('projects')
        .where('company_id', isEqualTo: companyId)
        .where('privacy', isEqualTo: 'public')
        .get();

    for (var doc in query.docs) {
      projects.add(Project.fromFirestore(doc));
    }
    return projects;
  }
}
