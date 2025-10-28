import 'package:flutter/services.dart';

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
}
