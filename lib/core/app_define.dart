import 'dart:io';
import 'package:app_kit/core/kt_export.dart';

import '../tools/hud.dart';
export 'package:decimal/decimal.dart';
export 'package:flutter/services.dart';

const kImaNil = 'http://picsum.photos/1000/400';

Function d = (String s) => Decimal.parse(s);

double kStaBarH(BuildContext context) =>
    MediaQueryData.fromView(View.of(context)).padding.top;

///如果是null 或者 空字符 就提示 tip 文案
bool isNil<T>(Object? v, [String tip = '', bool useSnack = true]) {
  bool f = false;
  // logs('---v.runtimeType---:${v.runtimeType}');
  if (v == null) {
    f = true;
  } else if (v.runtimeType.toString().contains('List')) {
    Object ls = v;
    if ((ls as List).isEmpty) f = true;
  } else {
    String s = '$v';
    if (s == 'null') f = true;
    if (s == 'true') f = true;
    if (s.isEmpty) f = true;
    if (s == '0') f = true;
    if (s == '0.0') f = true;
  }
  if (f && tip.isNotEmpty) {
    if (useSnack) {
      kPopSnack(tip);
    } else {
      kitPopText(tip);
    }
  }
  return f;
}

/// 吐司
//  Future<bool?> kitPopText(text,[ToastGravity? gravity,Color? textColor,Color? bgColor]) async {
//    await Fluttertoast.cancel();
//   return await Fluttertoast.showToast(
//     msg: text.toString(),
//     timeInSecForIosWeb: 3,
//     gravity: gravity??ToastGravity.CENTER,
//     textColor: textColor?? const Color(0xffffffff),
//     // backgroundColor: const Color(0xff3695ff),
//     backgroundColor:bgColor?? C.mainColor,
//   ).then((value) {
//     EasyLoading.dismiss();
//     return null;
//   });
// }

/// 导航栏下滑吐司
/// 导航栏下滑吐司
kPopSnack(text,
    {Color? bgColor, Color? textColor, int time = 1, Function? onFinish}) {
  logs('---Get.isSnackbarOpen--${Get.isSnackbarOpen}');
  if (!Get.isSnackbarOpen) {
    // Get.rawSnackbar()
    var me = Stack(
      children: [
        if (bgColor == null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: C.mainColor,
                    ))),
          ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: bgColor ?? C.transparent,
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
            child: Center(
                child: Text(
              text.toString(),
              maxLines: 20,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? C.white,
                  fontSize: 16.r,
                  fontWeight: FontWeight.w600),
            ))),
      ],
    );
    Future.delayed(Duration(milliseconds: 100), () {
      Get.snackbar(
        '', '',
        backgroundColor: bgColor ?? C.white.withOpacity(0.001),
        overlayBlur: 0,
        barBlur: 0,
        duration: Duration(seconds: time),
        // duration: Duration(seconds: 60),
        padding: EdgeInsets.zero,
        // margin: EdgeInsets.only(bottom: 0),
        // backgroundGradient: ,
        // padding: EdgeInsets.all(8.r),
        titleText: me,
        borderWidth: 0,
        snackbarStatus: (SnackbarStatus? x) {
          if (x == SnackbarStatus.CLOSED) {
            // logs('---onFinish--${onFinish}');
            // logs('---x--${x}');
            if (onFinish != null) {
              Future.delayed(Duration(milliseconds: 700), () {
                onFinish();
              });
            }
          }
        },
        messageText: Container(
          height: 0.1,
          color: C.transparent,
        ),
      );
    });
  } else {
    // _kPopSnack(text,bgColor: bgColor,textColor: textColor,time: time);
  }
}

Future<Uint8List> ima2U8(String url) async {
  final ByteData bytes = await rootBundle.load(url);
  final Uint8List list = bytes.buffer.asUint8List();
  return list;
}

bool get isRelease => inRelease;
bool get inRelease => bool.fromEnvironment("dart.vm.product");
bool get isDebug => inDebug;
bool get inDebug => (!bool.fromEnvironment("dart.vm.product"));
bool get isIOS => inIOS;
bool get inIOS => Platform.isIOS;
bool get isAndroid => inAndroid;
bool get inAndroid => Platform.isAndroid;
String get isSmart => 'smart';
String get isPatrol => 'patrol';
// bool get inV5 => dao.sited.domain == 'patrol';
