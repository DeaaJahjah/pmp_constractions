import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
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

  addClient(Client client, context) async {
    try {
  
      _db.collection('clients').doc(user!.uid).set(client.toJson());

      await Provider.of<DataProvider>(context, listen: false).fetchData();

      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  updateClient(Client client,context)async{
      try{
        Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.waiting);

await _db.collection('clients').doc(user!.uid).update(client.toJson());
 await Provider.of<DataProvider>(context, listen: false).fetchData();

 Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
           
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

      }on FirebaseException catch(e){
 Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);

      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
      }

  }
}
