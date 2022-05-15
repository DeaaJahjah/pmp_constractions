import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadeimage(String name, File image) async {
    try {
      await storage.ref(name).putFile(image);
      return storage.ref(name).getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
      return e.message.toString();
    }
  }
}
