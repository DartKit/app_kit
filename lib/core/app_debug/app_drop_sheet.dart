import 'package:app_kit/core/app_debug/app_debug.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AppDropSheet extends StatelessWidget {
  static String ifContainGotPwd(String phone) {
    String pwd = '';

    AppDebug.ls.map((e) {
      if (e.contains(phone)) {
        // pwd = e.split('/')[1];
      }
    }).toList();
    return pwd;
  }

  Function callback;
  String select;
  AppDropSheet({super.key, required this.callback, this.select = ''});

  @override
  Widget build(BuildContext context) {
    AppDebug.setLs();
    return Container(
        height: 600.r,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
              colors:  [Get.theme.primaryColor, Colors.white]),
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    String str = AppDebug.ls[index].first;
                    String str2 = AppDebug.ls[index].last;
                    String st = str.split('/').last.toString();
                    return InkWell(
                      onTap: () {
                        callback(st, AppDebug.ls[index]);
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                width: 1.r,
                                color:  Colors.transparent),
                            color: (str.contains(select) && select.isNotEmpty)
                                ? Colors.red.withOpacity(0.7)
                                : Colors.transparent),
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                        // child: AutoSizeText(str, maxLines: 1,minFontSize: 12,maxFontSize: 20, style: TextStyle(color: isPhone?C.black:Colors.pink,fontSize:isPhone? 18: 18, fontWeight: isPhone?AppFont.regular:AppFont.bold),)
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              str,
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            Text(str2),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: AppDebug.ls.length,
                )),
              ]),
        ));
  }

  static Future<void> fire(Widget bottomSheet) async {
    return await Get.bottomSheet(
      bottomSheet,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r))),
      ignoreSafeArea: false,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
