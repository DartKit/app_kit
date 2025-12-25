import 'dart:io';
import 'package:app_kit/core/kt_export.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CoOpenFile {
  static open({String url = '', File? file}) async {
    final Directory tempDir = await getTemporaryDirectory();
    var subPath = '';
    try {
      subPath = url.split('/').last.split('.').first;
    } catch (x) {
      subPath = DateTime.now().millisecondsSinceEpoch.toString();
    }

    String path = '${tempDir.path}/$subPath.${url.split('.').last}';
    if (file != null) path = file.path;
    logs('---path--$path');

    File x = file ?? File(path);
    var isExists = await x.exists(); // 文件存在
    if (isExists) {
      _openFile(x);
      // downloadFile(dio, mo.url, path);
      return;
    }
    _downloadFile(url, path);
  }

  static Future<String> savePath(String url) async {
    final Directory tempDir = await getTemporaryDirectory();
    var subPath = '';
    try {
      subPath = url.split('/').last.split('.').first;
    } catch (x) {
      subPath = DateTime.now().millisecondsSinceEpoch.toString();
    }

    String path = '${tempDir.path}/$subPath.${url.split('.').last}';
    return path;
  }

  static Future _openFile(File file) async {
    final url = file.path;
    if (await Permission.manageExternalStorage.isGranted &&
        await Permission.storage.isGranted) {
      await OpenFile.open(url)
          .then((value) => print('value == ${value.message}'));
    } else {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();
      await OpenFile.open(url)
          .then((value) => print('value == ${value.message}'));
    }
  }

  static Future _downloadFile(String url, String savePath) async {
    try {
      EasyLoading.instance
        ..maskColor = Colors.black.withOpacity(0.2)
        ..progressColor = Colors.white
        ..textColor = CC.white
        ..backgroundColor = CC.mainColor;

      var dio = Dio();
      Response response = await dio.get(
        url,
        onReceiveProgress: _showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          // validateStatus: (status) { return status < 500;}
        ),
      );
      // print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      logs('---file.path--${file.path}');
      _openFile(file);
    } catch (e) {
      print(e);
    }
  }

  static void _showDownloadProgress(received, total) {
    logs('---total--$total---received--$received');
    if (total != -1) {
      double f = received / total * 100;
      String pr = '${f.toStringAsFixed(0)} %';
      logs('---pr--$pr');
      EasyLoading.showProgress(received / total, status: '\n$pr');
      if (received >= total) EasyLoading.dismiss();
    }
  }
}
