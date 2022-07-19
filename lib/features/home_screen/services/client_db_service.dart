import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/home.dart';
import 'package:provider/provider.dart';

class ClientDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;

  Future<List<Client>> getClients() async {
    var queryData = await _db.collection('clients').get();
    List<Client> clients = [];

    for (var doc in queryData.docs) {
      clients.add(Client.fromFirestore(doc));
    }

    return clients;
  }

  Future<Client> getClientById(String id) async {
    var doc = await _db.collection('clients').doc(id).get();

    return Client.fromFirestore(doc);
  }

  //get client photo url stream
  Stream<String> getClientPhotoUrl(String id) {
    return _db
        .collection('clients')
        .doc(id)
        .snapshots()
        .map((doc) => doc.data()!['profile_pic_url']);
  }

  addClient(Client client, context) async {
    try {
      _db.collection('clients').doc(user!.uid).set(client.toJson());

      await Provider.of<DataProvider>(context, listen: false).fetchData();

      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      NotificationDbService().addNotification(NotificationModle(
        title: 'Welcome',
        body: 'hi ${client.name} Have a great time',
        type: NotificationType.none,
        imageUrl: imageUrl,
        isReaded: false,
        pauload: '/notification',
        createdAt: DateTime.now(),
      ));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  updateClient(Client client, context) async {
    try {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.waiting);

      await _db.collection('clients').doc(user!.uid).update(client.toJson());
      await Provider.of<DataProvider>(context, listen: false).fetchData();

      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      const snackBar = SnackBar(content: Text('Sucess MSG'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      final snackBar = SnackBar(
          backgroundColor: Colors.red[500], content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
