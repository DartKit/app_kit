import 'package:app_kit/core/app_debug/app_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppDebug {

  static String seledUrl = '';
  static String userInfo = '';
  static List<String> urls = [];
  static Function(String url, int index)?  onChangeHost;
  static List get data => _data;
  static List get req => _req;


  static List _data = [];
  static List _req = [];



  static addLog(Object c) {
    if (_data.length > 10) _data.removeLast();
    _data.insert(0, c);
  }

  static addReq(Object c) {
    if (_req.length > 20) _req.removeLast();
    _req.insert(0, c);
  }

  static bool get isShowing => AppOverLay.isShowing;

  /*
  
  * */

  static Future<void> setLs() async {
    ls.clear();
    List<String> son = lsStr.split('\n');
    for (var o in son) {
      List<String> tm = o.split('@@');
      if (tm.length >= 2)  ls.add(tm);
    }
  }

  static List<List<String>> ls = [];

  ///  严格按照【账号@@密码@@昵称】格式
  static String lsStr = '''
18674049587@@shidai20241204-@@管理员
''';

  static void snackbar(text, {Color? bgColor, Color? textColor, num time = 3}) {
    Get.snackbar('', '',
        backgroundColor: bgColor ?? Colors.blue,
        duration: time.runtimeType == int
            ? Duration(seconds: time ~/ 1)
            : Duration(milliseconds: time * 1000 ~/ 1),
        padding: EdgeInsets.all(8),
        titleText: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Center(
                child: Text(
              text.toString(),
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )),
          ],
        ),
        messageText: Container());
  }

  static addDebug() async {
    AppOverLay.times++;
    var i = AppOverLay.timesAll - AppOverLay.times;
    if (0 <= i && i <= 3) {
      if (i > 0) {
        if (!AppOverLay.isShowing) {
          snackbar('进入开发者模式。还需$i次', time: 0.8);
        }
      }
      if (AppOverLay.times >= AppOverLay.timesAll) {
        AppOverLay.show(context: Get.context!, view: AppOverLay.bugView());
      }
    }
  }
}
