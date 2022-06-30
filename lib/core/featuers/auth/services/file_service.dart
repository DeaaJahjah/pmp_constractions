import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class FileService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadeimage(
      String name, File image, BuildContext context) async {
    try {
      await storage.ref(name).putFile(image);
      return storage.ref(name).getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.toString());
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
      showErrorSnackBar(context, e.message!);
      return 'error';
    }
  }

  Future<String> uploadeFile(
      String name, File file, BuildContext context) async {
    try {
      await storage.ref(name).putData(await file.readAsBytes());
      return storage.ref(name).getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.toString());
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
      showErrorSnackBar(context, e.message!);
      return 'error';
    }
  }

  //download file
  Future<void> requestDownload(String _url, String _name) async {
    final dir =
        await getApplicationDocumentsDirectory(); //From path_provider package
    var _localPath = dir.path;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        url: _url,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: false,
      );
      print(_taskid);
    });
  }
}
