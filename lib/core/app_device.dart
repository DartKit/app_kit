import 'dart:io';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/extension/string_add.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDevice {
  static String versionName = '';
  static String system_version = '';
  static String model = '';
  static int versionCode = 1;
  static bool has_version = false;
  static Map<String, dynamic>? _deviceData;

  // static deviceData([bool hideUser = false]) {
  //   if (hideUser) {
  //     if (_deviceData != null) {
  //       _deviceData!['mobile'] = dao.mobile.phoneToStarNumber;
  //       if (!isRelease) _deviceData!['mobile'] = dao.mobile;
  //     }
  //   }
  //   return _deviceData;
  // }

  ///获取设备信息
  static Future<dynamic> deviceInfo({String mobile = '',String channel = ''}) async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;
    if (Platform.isIOS) {
      iosInfo = await deviceInfoPlugin.iosInfo;
    } else {
      androidInfo = await deviceInfoPlugin.androidInfo;
    }
    _deviceData = await _readDeviceInfo(androidInfo, iosInfo,mobile: mobile,channel:channel);
    logs(_deviceData);
    return _deviceData;
  }

  static _readDeviceInfo(
      AndroidDeviceInfo? androidInfo, IosDeviceInfo? iosInfo,{String mobile = '',String channel = ''}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber.toInt;
    Map<String, dynamic> data = <String, dynamic>{
      //手机品牌加型号
      "brand": Platform.isIOS
          ? iosInfo?.utsname.nodename
          : "${androidInfo?.brand} ${androidInfo?.model}",
      "model":
          Platform.isIOS ? iosInfo?.utsname.nodename : "${androidInfo?.model}",
      //当前系统版本
      "system_version": Platform.isIOS
          ? iosInfo?.systemVersion
          : androidInfo?.version.release,
      //系统名称
      "platform": Platform.isIOS ? iosInfo?.systemName : "android",
      //是不是物理设备
      "is_physical_device": Platform.isIOS
          ? iosInfo?.isPhysicalDevice
          : androidInfo?.isPhysicalDevice,
      //用户唯一识别码
      "id": Platform.isIOS ? iosInfo?.identifierForVendor : androidInfo?.id,
      //手机具体的固件型号/Ui版本
      "incremental": Platform.isIOS
          ? iosInfo?.systemVersion
          : androidInfo?.version.incremental,
      "version_name": packageInfo.version,
      "version_code": packageInfo.buildNumber,
      if (channel.isNotEmpty)  "channel": channel,
      if (mobile.isNotEmpty)  "mobile": mobile,
    };
    system_version = data['system_version'];
    model = data['model'];
    return data;
  }
}
