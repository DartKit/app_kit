import 'package:app_kit/core/app_debug/app_debug.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppRequestPage extends StatefulWidget {
  const AppRequestPage({super.key});

  @override
  State<AppRequestPage> createState() => _AppRequestPageState();
}

class _AppRequestPageState extends State<AppRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '找接口',
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
                    ClipboardData(text: AppDebug.req[index].toString()));
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
                // Get.showSnackbar(sc);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppDebug.req[index]}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20,
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
          itemCount: AppDebug.req.length,
        ),
      ),
    );
  }
}
