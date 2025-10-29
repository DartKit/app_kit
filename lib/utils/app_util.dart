import 'package:app_kit/core/kt_export.dart';

class AppUtil {
  ///设置横屏或竖屏
  ///isVerticalScreen 是否竖屏
  static setScreenLandscape({required bool isVerticalScreen}) async {
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        isVerticalScreen
            ? DeviceOrientation.portraitUp
            : DeviceOrientation.landscapeLeft,
        isVerticalScreen
            ? DeviceOrientation.portraitDown
            : DeviceOrientation.landscapeRight,
      ],
    );
  }

  static DateTime? lastQuitTime;
  static Future<bool> onWillPop({bool noBack = false}) async {
    if (noBack) Future(() => false);
    if (lastQuitTime == null || DateTime.now().difference(lastQuitTime!).inSeconds > 1) {
      kPopSnack('快速点两次 退出${kdao.app_name}', bgColor: Colors.red);
      lastQuitTime = DateTime.now();
      return Future(() => false);
    } else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future(() => true);
    }
  }
}
