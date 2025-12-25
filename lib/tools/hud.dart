import 'package:app_kit/core/kt_export.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/kt_dao.dart';

Future<void> hudText(String text, {bool userInteractions = true}) async {
  EasyLoading.instance
    ..userInteractions = userInteractions
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType.custom
    ..boxShadow = [BoxShadow(color: CC.green)]
    ..indicatorSize = 18.r
    ..displayDuration = Duration(seconds: 3)
    ..indicatorColor = CC.white
    ..textColor = CC.white
    ..textStyle =
        TextStyle(color: CC.white, fontSize: 16.r, fontWeight: FontWeight.w600)
    ..loadingStyle = EasyLoadingStyle.custom
    ..contentPadding = EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r)
    ..maskColor = Colors.transparent;

  // EasyLoading.showToast(text);
  return EasyLoading.showToast(text);
  //  Future.delayed(Duration(milliseconds: 300),() async{
  //   return await EasyLoading.showToast(text);
  // });
}

void initEasyLoading(
    {bool userInteractions = false,
    bool dismissOnTap = false,
    bool isAction = false}) {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..progressColor = Colors.green
    ..textPadding = EdgeInsets.zero
    ..contentPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 10)
    ..backgroundColor = Colors.black.withOpacity(0.0)
    ..boxShadow = [BoxShadow(color: Colors.transparent)]
    ..indicatorColor = CC.mainColor
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.0)
    ..userInteractions = userInteractions
    ..maskType = EasyLoadingMaskType.custom
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..dismissOnTap = dismissOnTap;
}

Future<void> kitPopText(text) async {
  return hudText(text);
}

Future<void> kitHud(
    {bool userInteractions = false,
    bool dismissOnTap = false,
    bool isAction = false}) async {
  int timeGap = 1000;
  if (isAction) timeGap = 0;
  Future.delayed(Duration(milliseconds: timeGap), () {
    DateTime date1 = DateTime.now();
    Duration du = date1.difference(kdao.date0);
    // logs('---du--${du}');
    // logs('---du.inMilliseconds--${du.inMilliseconds}---du--${du}');
    if ((kdao.reqing == false) && kdao.req_end) return null;

    logs(
        '--isAction--:$isAction---du.inMilliseconds > timeGap--${du.inMilliseconds > timeGap}');

    if ((isAction) || (du.inMilliseconds > timeGap)) {
      // EasyLoading.dismiss();
      initEasyLoading();
      return EasyLoading.show(
        status: '',
      ).then((value) {
        Future.delayed(Duration(milliseconds: 20000), () {
          EasyLoading.dismiss();
        });
      });
    }
  });
}

void kitHideLoading() {
  kdao.req_end = true;
  kdao.date0 = DateTime.now();
  // logs('---date0--${date0}');
  EasyLoading.dismiss();
}
