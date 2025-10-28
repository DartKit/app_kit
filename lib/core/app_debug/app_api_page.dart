import 'package:flutter/material.dart';
import 'package:app_kit/core/app_debug/app_debug.dart';

class AppApiPage extends StatefulWidget {
  const AppApiPage({super.key});

  @override
  State<AppApiPage> createState() => _AppApiPageState();
}

class _AppApiPageState extends State<AppApiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '接口环境',
          style: TextStyle(color: Color(0xFF84C2B0), fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      '重启app后复原归位',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    )),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      var url = AppDebug.urls[index];
                      AppDebug.seledUrl = url;
                      if (AppDebug.onChangeHost != null) AppDebug.onChangeHost!(url, index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppDebug.urls[index],
                                style: TextStyle(color: Color(0xFF84C2B0), fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Expanded(child: SizedBox()),
                              Offstage(
                                offstage: index != (AppDebug.urls.indexOf(AppDebug.seledUrl)),
                                child: Icon(Icons.done),
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: AppDebug.urls.length,
              ),
            ),
          ),
          if (AppDebug.userInfo.toString().isNotEmpty)
            Expanded(
                child: ListView(
              children: [
                Text(AppDebug.userInfo.toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            )),
        ],
      ),
    );
  }
}
