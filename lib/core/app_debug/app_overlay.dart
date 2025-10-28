import 'package:app_kit/core/app_debug/app_api_page.dart';
import 'package:app_kit/core/app_debug/app_debug.dart';
import 'package:app_kit/core/app_debug/app_loc2_page.dart';
import 'package:app_kit/core/app_debug/app_loc_page.dart';
import 'package:dio_log/http_log_list_widget.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:dio_log/utils/log_pool_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_kit/core/app_debug/app_request_page.dart';

class AppOverLay {
  static int times = 0;
  static int timesAll = 15;
  static OverlayEntry? _holder;
  static bool _isShowing = false;

  static init({required List<String> urls,}) {

  }

  static set isShowing(bool f) {
    _isShowing = f;
    if (_isShowing) {
      // show(context: Get.context!, view: _view!);
      refresh();
    } else {
      remove();
    }
  }

  static bool get isShowing => _isShowing;

  static Widget? view;

  static void remove() {
    if (_holder != null) {
      _holder!.remove();
      _holder = null;
      view = Container();
    }
  }

  static void show({required BuildContext context, required Widget view}) {
    if (_isShowing) {
      remove();
      times = 0;
      _isShowing = false;
      AppDebug.snackbar('开发者模式已关闭', bgColor: Colors.red);
      return;
    }

    AppOverLay.view = view;
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          child: _buildDraggable(context));
    });

    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(overlayEntry);
    _holder = overlayEntry;
    _isShowing = true;
    times = 0;
  }

  static _buildDraggable(context) {
    return Draggable(
      feedback: view!,
      onDragStarted: () {
        // logs('onDragStarted:');
      },
      onDragEnd: (detail) {
        // logs('onDragEnd:${detail.offset}');
        createDragTarget(offset: detail.offset, context: context);
      },
      childWhenDragging: Container(),
      child: view!,
    );
  }

  static void refresh() {
    _holder!.markNeedsBuild();
  }

  static void createDragTarget(
      {required Offset offset, required BuildContext context}) {
    if (_holder != null) {
      _holder!.remove();
    }

    _holder = OverlayEntry(builder: (context) {
      bool isLeft = true;
      if (offset.dx + 100 > MediaQuery.of(context).size.width / 2) {
        isLeft = false;
      }

      double maxY = MediaQuery.of(context).size.height - 100;

      return Positioned(
          top: offset.dy < 50
              ? 50
              : offset.dy < maxY
                  ? offset.dy
                  : maxY,
          left: isLeft ? 0 : null,
          right: isLeft ? null : 0,
          child: DragTarget(
            onWillAcceptWithDetails: (data) {
              // logs('onWillAccept: $data');
              return true;
            },
            onAcceptWithDetails: (data) {
              // logs('onAccept: $data');
              // refresh();
            },
            onLeave: (data) {
              // logs('onLeave');
            },
            builder: (BuildContext context, List incoming, List rejected) {
              return _buildDraggable(context);
            },
          ));
    });
    Overlay.of(context).insert(_holder!);
  }

  static Widget bugView() {
    return InkWell(
      onTap: () {},
      child: _baseView(),
    );
  }

  static Widget _baseView() {
    return InkWell(
      onTap: () {
        view = _toolView();
        refresh();
      },
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: Colors.deepOrange),
          color: Colors.green,
        ),
        child: Icon(Icons.bug_report_outlined),
      ),
    );
  }

  static Widget _toolView() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: Colors.deepOrange),
        color: Colors.green,
      ),
      child: Row(
        children: [
          _item('环境', Icon(Icons.api), () {
            Get.to(() => AppApiPage());
          }),
          _item('LOG', Icon(Icons.article), () {
            /// Sets the maximum number of entries for logging 设置记录日志的最大条数
            LogPoolManager.getInstance().maxCount = 50;

            ///Add the isError method implementation to LogPoolManager so that request messages defined as errors are displayed in red font
            LogPoolManager.getInstance().isError =
                (res) => res.resOptions == null;

            ///Disabling Log Printing
            DioLogInterceptor.enablePrintLog = true;
            Get.to(() => HttpLogListWidget());
          }),
          _item('找接口', Icon(Icons.power), () {
            Get.to(() => AppRequestPage());
          }),
          // _item('日志', Icon(Icons.article), (){
          //   Get.to(()=>AppLogPage());
          // }),

          _item('定位', Icon(Icons.article), () {
            Get.to(() => AppLocPage());
          }),
          _item('loc', Icon(Icons.article), () {
            Get.to(() => AppLoc2Page());
          }),
          _item('关闭', Icon(Icons.close), () {}),
        ],
      ),
    );
  }

  static Widget _item(String name, Icon icon, var ontap) {
    return InkWell(
      onTap: () {
        view = _baseView();
        refresh();
        ontap();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            icon,
            Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
