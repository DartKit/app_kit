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
      List<String> tm = o.split('@');
      ls.add(tm);
    }
  }

  static List<List<String>> ls = [];

  static String lsStr = '''
xx/xx/15227544572@省平台-省级管理员
xx/xx/13886443450@省平台-市1管理员
xx/xx/13994500896@省平台-区1管理员
xx/xx/13456656655@省平台-区2管理员
xx/xx/13425526776@省平台-市2管理员
xx/xx/12345545554@省平台-区3管理员
xx/xx/15478776728@省平台-区4管理员
xx/xx/12355455656 直辖市管理员
96/小天/18168860016@园林局/园林局管理员
--/超管/18674049587@测试项目超级管理员
--/超管/18772264622@杨春湖公园/园长
95/园长/18168866665@东坡湖公园/园长
95/保安队长/18177777777@东坡湖公园/保安
95/公园巡查员/18168866664@东坡湖公园/巡查员
95/小武/18168860015@园林局绿化科/绿化科管理员
94/小组/18168860014@道路整改单位/养护单位班组长（道路）
93/小班/18168860013@道路整改单位/养护单位班组长（道路）
90/运维/18168861008@园林局绿化队/绿化队管理员绿化队巡查员
89/小邱/18168861007@公园管理中心/园长
88/小章/18168861006@公园管理中心/养护单位管理员（公园）
87/小罗/18168860012@建管站武汉新区建设/市政施工方(施工单位管理员）
86/小林/18168860011@建管站武汉琴台生态/市政施工方(施工单位管理员）
84/小万/18168860010@建管站/第三方巡查单位管理员（建管站）
83/小周/18168860009@建管站/建管站巡查员
82/小赵/18168861005@公园管理中心/公园管理中心管理员
81/小游/18168860007@建管站/建管站管理员
80/小袁/18168861004@三环线片区黄金口片区/片长（道路）
79/小佘/18168861003@龙阳大道片区琴断口片区/片长（道路）
78/小曾/18168861002@四新东片区四新西片区/片长（道路）
77/小科/18168860006@绿化队/第三方巡查单位巡查员（道路）
76/小汪/18168861001@江城大道片区国博大道片区/片长（道路）
75/小阿/18168860005@绿化队/第三方巡查单位管理员（道路）
74/小朱/18168861000@晴川大道片区鹦鹉大道片区/片长（道路）
73/小肖/18168860004@绿化队ABC/绿化队巡查员
72/小李/18168860003@绿化队/社区管理员
71/小高/18168860002@绿化队/道路管理员
70/小王/18168860001@绿化队/绿化队管理员''';

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
