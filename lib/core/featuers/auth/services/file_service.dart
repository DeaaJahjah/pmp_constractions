import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/auth_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/download_state_provider.dart';
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
      String name, Uint8List file, BuildContext context) async {
    try {
      await storage.ref(name).putData(file);
      return storage.ref(name).getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.toString());
      Provider.of<AuthSataProvider>(context, listen: false)
          .changeAuthState(newState: AuthState.notSet);
      showErrorSnackBar(context, e.message!);
      return 'error';
    }
  }

  Future<String> uploadeAttchment(
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

  Dio dio = Dio();
  double progress = 0;
  Future download2(String url, BuildContext context) async {
    try {
      String savePath = '/storage/emulated/0/Download/' "file";

      /// get storge permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      Response response = await dio.get(
        url,
        onReceiveProgress: (received, total) {
          /// update the UI state
          progress = (received / total * 100).roundToDouble();
          Provider.of<DownloadStateProvider>(context, listen: false)
              .updateState(progress);
        },
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );

      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      ///download is complated
      showSuccessSnackBar(context, 'Download is completed');

      /// restet the ui
      progress = 0;
      Provider.of<DownloadStateProvider>(context, listen: false)
          .updateState(progress);
    } catch (e) {
      showErrorSnackBar(context, 'Download is failed');
      progress = 0;
      Provider.of<DownloadStateProvider>(context, listen: false)
          .updateState(progress);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      progress = (received / total * 100).toStringAsFixed(0) + "%";
    }
  }
}
