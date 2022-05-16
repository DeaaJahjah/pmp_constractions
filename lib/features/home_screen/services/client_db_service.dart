import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/models/client.dart';
import 'package:pmpconstractions/features/home_screen/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
    Map<String, dynamic>? cc = doc.data() as Map<String, dynamic>;

    return Client.fromFirestore(doc);
  }

  addClient(Client client, context) async {
    try {
      final pref = await SharedPreferences.getInstance();
      _db.collection('client').doc(pref.getString('uid')).set(client.toJson());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseException catch (e) {
      print(e.toString());
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
