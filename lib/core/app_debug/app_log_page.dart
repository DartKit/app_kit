import 'package:app_kit/core/app_debug/app_debug.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLogPage extends StatefulWidget {
  const AppLogPage({super.key});

  @override
  State<AppLogPage> createState() => _AppLogPageState();
}

class _AppLogPageState extends State<AppLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '请求日志',
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
                    ClipboardData(text: AppDebug.data[index].toString()));
                AppDebug.snackbar('已经复制到剪贴板');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppDebug.data[index]}',
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
          itemCount: AppDebug.data.length,
        ),
      ),
    );
  }
}
