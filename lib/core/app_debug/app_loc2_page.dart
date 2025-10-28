import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppLoc2Page extends StatefulWidget {
  const AppLoc2Page({super.key});
  static List ls = [];
  @override
  State<AppLoc2Page> createState() => _AppLoc2PageState();
}

class _AppLoc2PageState extends State<AppLoc2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '定位日志2',
          style: TextStyle(
              color: Color(0xFF84C2B0),
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(text: AppLoc2Page.ls[index].toString()));
                Get.snackbar(
                  '',
                  '',
                  backgroundColor: Colors.orange.withOpacity(0.4),
                  titleText: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Center(
                          child: Text(
                        '已经复制到剪贴板',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                    ],
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLoc2Page.ls[index]}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w300),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: AppLoc2Page.ls.length,
        ),
      ),
    );
  }
}
