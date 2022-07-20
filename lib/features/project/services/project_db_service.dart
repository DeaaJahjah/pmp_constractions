import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/project/models/project.dart';
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
              createdAt: DateTime.now(),
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

      showErrorSnackBar(context, e.message!);
    }
  }

  updateProject(Project project, context) async {
    try {
      await _db
          .collection('projects')
          .doc(project.projectId)
          .update(project.toJson());
      const snackBar = SnackBar(
        content: Text('Project updated successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // refresh the data
      Provider.of<DataProvider>(context, listen: false).fetchProjects();
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      print(e);

      showErrorSnackBar(context, e.message!);
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

  Stream<List<String>> userProjectsIDS(String userId, String collectionName) {
    // return _db.collection(collectionName).doc(userId).get().then((doc) {
    //   var data = doc.data()!['projects_ids'] ?? [];
    //   List<String> projectsIds = [];
    //   for (var id in data) {
    //     projectsIds.add(id);
    //   }

    //   //  print(projectsIds);
    //   return projectsIds;
    // });

    return _db.collection(collectionName).doc(userId).snapshots().map((doc) {
      var data = doc.data()!['projects_ids'] ?? [];
      List<String> projectsIds = [];
      for (var id in data) {
        projectsIds.add(id);
      }

      print(projectsIds);
      return projectsIds;
    });
  }

  Future<List<Project>> getOpenProjects(List<String> projectIDS) async {
    // List<String> projectIDS =
    //     await userProjectsIDS(user.uid, getcCollectionName(user.displayName));
    var uid = FirebaseAuth.instance.currentUser!.uid;

    List<Project> projects = [];
    if (projectIDS.isNotEmpty) {
      for (var projectId in projectIDS) {
        var doc = await _db.collection('projects').doc(projectId).get();
        var project = Project.fromFirestore(doc);
        if (project.isOpen && project.memberIn(uid)) {
          projects.add(project);
        }
      }
    }
    print(projects.length);
    return projects;
  }

  // get opne projects for user real time

  Future<List<Project>> getPublicProjects(List<String> projectsIDs) async {
    List<DocumentSnapshot<Map<String, dynamic>>> queryData = [];

    for (var docID in projectsIDs) {
      queryData.add(await _db.collection('projects').doc(docID.trim()).get());
    }

    List<Project> projects = [];

    for (var doc in queryData) {
      if (doc.exists) {
        Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;
        if (cc['privacy'] == 'public') {
          projects.add(Project.fromFirestore(doc));
        }
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
  Stream<Project?> getProjectUpdates(String id) {
    return _db.collection('projects').doc(id).snapshots().map((doc) {
      if (doc.exists) {
        return Project.fromFirestore(doc);
      }
      return null;
    });
  }

  Stream<List<Project>> geCompanyOpenProjects(String uid) {
    return _db
        .collection('projects')
        .where('company_id', isEqualTo: uid)
        .where('is_open', isEqualTo: true)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => Project.fromFirestore(doc)).toList());
  }

  // show the copmpany projects
  Stream<List<Project>> geCompanyProjects(String companyId) {
    List<Project> projects = [];

    //get projects realtime updates
    return _db
        .collection('projects')
        .where('company_id', isEqualTo: companyId)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => Project.fromFirestore(doc)).toList());
  }

  // for any one vist the company profile
  Stream<List<Project>> geCompanyPublicProjects(String companyId) {
    List<Project> projects = [];

    //get projects realtime updates
    return _db
        .collection('projects')
        .where('company_id', isEqualTo: companyId)
        .where('privacy', isEqualTo: ProjectPrivacy.public.name)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => Project.fromFirestore(doc)).toList());
  }

  //delete project
  Future<void> deleteProject(String projectId, List<MemberRole> members) async {
    for (MemberRole member in members) {
      // remove project id from all members

      await _deleteProjectFromMemberList(
          collectionName: member.collectionName!,
          projectId: projectId,
          memberId: member.memberId);
    }
    await _db.collection('projects').doc(projectId).delete();
  }

  //dlelete project from member list
  Future<void> _deleteProjectFromMemberList(
      {required String collectionName,
      required String projectId,
      required String memberId}) async {
    await _db.collection(collectionName).doc(memberId).update(
      {
        'projects_ids': FieldValue.arrayRemove([projectId])
      },
    );
  }
}
