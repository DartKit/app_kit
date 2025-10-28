import 'dart:io';
import 'package:app_kit/core/kt_export.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../widgets/kit_view.dart';

class AppPermission {
  // Future<void> init() async {
  //   return await permissionStorageCamera();
  // }

  // Future<void> permissionStorageCamera() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //     Permission.camera
  //   ].request();
  // }

  Future<void> locationWhenInUse() async {
    bool f = await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (f == false) {
      openAppSettings();
      return;
    }
  }

  static ({String name, String tip}) alertPermissionTitles(
      Permission permission,{String tips = ''}) {
    String name = '';
    String atip = tips;
    logs('---permission.value--${permission.value}');
    switch (permission.value) {
      case 3:
      case 4:
      case 5:
        {
          name = '定位';
          atip = '为了实现地图巡查养护相关业务：人员位置、巡查轨迹、计算巡查距离，需要$name权限。如果拒绝开启，将无法使用上述功能。';
        }
        break;
      case 1:
        {
          name = '相机';
          atip =
              '为了实现随手拍页面拍照、问题详情养护拍照、扫一扫绑定工牌、扫一扫查看植物二维码介绍，智库问题咨询拍摄视频，需要$name权限。如果拒绝开启，将无法使用上述功能。';
        }
        break;
      case 9:
      case 10:
        {
          name = '相册访问';
          atip =
              '为了实现将问题详情图片保存到相册，随手拍提报、问题详情养护、以及图片编辑从相册选图上传，需要$name权限。如果拒绝开启，将无法使用上述功能。';
        }
        break;
      case 15:
        {
          name = '存储';
          atip = '为了实现问题详情图片保存到相册，需要$name权限。如果拒绝开启，将无法使用上述功能。';
        }
        break;
      default:
        {}
    }

    return (name: name, tip: atip);
  }

  static Future<void> alertPermissionReqTalkShow(Permission permission,{String tips = ''}) async {
    ({String name, String tip}) tem = alertPermissionTitles(permission,tips: tips);
    String name = tem.name;
    String tip = tem.tip;
    KitView.alert(
        title: name + '权限申请说明',
        content: '当前需要申请$name权限，$tip',
        noCancel: true,
        barrierDismissible: true,
        autoDismiss: false,
        alignment: Alignment.topCenter);
  }

  static Future<void> alertOpenAppSettings(Permission permission,
      {bool hasCancel = false,String tips = ''}) async {
    ({String name, String tip}) tem = alertPermissionTitles(permission,tips:tips);
    String name = tem.name;
    String tip = tem.tip;
    KitView.alert(
        content: '当前无$name权限，$tip',
        noCancel: !hasCancel,
        barrierDismissible: true,
        autoDismiss: false,
        alignment: Alignment.topCenter,
        sure: () async {
          PermissionStatus status = await permission.request();
          if (status.isGranted) {
            // if (((permission == Permission.location)||(permission == Permission.locationAlways)||(permission == Permission.locationWhenInUse))) LocManage.setLoc = true;
            Get.back();
            return;
          }
          Future.delayed(Duration(milliseconds: 200), () => openAppSettings());
        },
        cancel: () async {
          PermissionStatus status = await permission.request();
          if (status.isGranted) {
            // if (((permission == Permission.location)||(permission == Permission.locationAlways)||(permission == Permission.locationWhenInUse))) LocManage.setLoc = true;
          } else {
            logs('---Get.rootDelegate--${Get.previousRoute}');
            Get.back();
          }
        });
  }

  //判断是否有权限
  static Future<bool> isGranted(Permission permission,
      {bool hasCancel = false,String tip = '',}) async {
    logs('---permission.value--${permission.value}');
    PermissionStatus status;
    if ((permission == Permission.photos) && (isAndroid)) {
      logs('---permission-11-$permission');
      return await getStoragePermission();
    }
    var isg = await permission.isGranted;
    if (isg == false) {
      await alertPermissionReqTalkShow(permission,tips: tip);
    }
    status = await permission.request();
    logs('检测权限$status');
    if (status.isGranted) {
      //权限通过
    } else if (status.isDenied) {
      //权限拒绝， 需要区分IOS和Android，二者不一样
      logs('---status.isDenied--${status.isDenied}');
      return await requestPermission(permission, hasCancel: true,tip: tip);
    } else if (status.isPermanentlyDenied) {
      logs('---status.isPermanentlyDenied--${status.isPermanentlyDenied}');
      //权限永久拒绝，且不在提示，需要进入设置界面
      alertOpenAppSettings(permission, hasCancel: true,tips:tip);
    } else if (status.isRestricted) {
      logs('---status.isRestricted--${status.isRestricted}');
      //活动限制（例如，设置了家长///控件，仅在iOS以上受支持。
      alertOpenAppSettings(permission, hasCancel: hasCancel,tips:tip);
    } else {
      logs('---第一次申请');
      //第一次申请
      return await requestPermission(permission, hasCancel: hasCancel,tip: tip);
    }
    return status.isGranted;
  }

  //申请权限
  static Future<bool> requestPermission(Permission permission,
      {bool hasCancel = false,String tip = ''}) async {
    PermissionStatus status = await permission.request();
    logs('权限状态$status');

    if (!status.isGranted) {
      alertOpenAppSettings(permission, hasCancel: hasCancel,tips:tip);
    }
    return status.isGranted;
  }

  // static Future<bool> permissionStorageCamera() async {
  //   // Map<Permission, PermissionStatus> statuses = await [
  //   //   Permission.photos,
  //   //   Permission.videos,
  //   //   Permission.audio,
  //   // ].request();
  //   return await Permission.photosAddOnly.request().isGranted;
  // }

  static Future<bool> getStoragePermission() async {
    bool permissionGranted = false;
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    logs('---android.version.sdkInt--${android.version.sdkInt}');
    // Android 14 SDK         API level 34
    // Android 13 SDK         API level 33
    // Android 12L SDK         API level 32
    // Android 12 SDK         API level 31
    // Android 11 SDK         API level 30
    // Android 10 SDK         API level 29
    // Android 9 SDK         API level 28
    // Android 8.1 SDK         API level 27
    // Android 8.0 SDK         API level 26
    // 原文链接：https://blog.csdn.net/weixin_41957626/article/details/130305674
    if (android.version.sdkInt < 33) {
      var f = await Permission.storage.isGranted;
      logs('---f-fff-$f');
      if (f == false) {
        KitView.alert(
            title: '相册存储权限使用说明：',
            content:
                '为了实现将问题详情图片保存到相册，以及图片编辑从相册选图上传，需要相册的存储权限。如果拒绝开启，将无法使用上述功能。',
            barrierDismissible: true,
            noCancel: true,
            alignment: Alignment.topCenter,
            sure: () async {});
      }
      if (await Permission.storage.request().isGranted) {
        permissionGranted = true;
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied) {
        permissionGranted = false;
      }
    } else {
      var f = await Permission.photos.isGranted;
      logs('---f-fff-$f');
      if (f == false) {
        KitView.alert(
          title: '相册权限申请说明：',
          content:
              '为了实现将问题详情图片保存到相册，以及图片编辑从相册选图上传，需要相册权限。如果拒绝开启，将无法使用上述功能。',
          barrierDismissible: true,
          noCancel: true,
          alignment: Alignment.topCenter,
        );
      }
      if (await Permission.photos.request().isGranted) {
        permissionGranted = true;
      } else if (await Permission.photos.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.photos.request().isDenied) {
        permissionGranted = false;
      }
      logs('---permissionGranted--$permissionGranted');
      // await Permission.photos.request();
      // await Permission.videos.request();
      // await Permission.audio.request();
    }
    return permissionGranted;
  }

  bool unGotPermission(PermissionStatus st) {
    bool ff = ((st == PermissionStatus.denied) ||
        (st == PermissionStatus.permanentlyDenied));
    return ff;
  }

  bool hasGotPermission(PermissionStatus st) {
    return ((st == PermissionStatus.granted) ||
        (st == PermissionStatus.restricted) ||
        (st == PermissionStatus.limited) ||
        (st == PermissionStatus.provisional));
  }

  static Future<bool> isGrantedLocation({required bool isGrantedIftoLoc, Function(bool)? call}) async {
    // var f = await Permission.location.isGranted;
    // if(!f) KitView.alert(
    //     title: '获取位置信息权限说明：',
    //     content: '我们使用您的获取位置信息权限，是用于巡查员进行巡查业务在地图上实时显示当前的位置，绘制巡查轨迹线，计算巡查距离等。',
    //     alignment: Alignment.topCenter,
    //     barrierDismissible:true,
    //     noCancel: true,
    //     sure: () async{
    //
    //     });

    // if (inAndroid) {
    //   if (AppDevice.model.contains('NOH-AN01') == false) {
    //     if (await LocationCheck.checkIsOpen() == false) return false;
    //   }
    // }

    bool isPermitted =
        await AppPermission.isGranted(Permission.location, hasCancel: true);
    logs('isPermitted=$isPermitted');
    // if ((isPermitted == true) && isGrantedIftoLoc) {
    //   if(LocManage.isLocing == false) LocManage().fireLocation(); // fireLocation 里面又循环调用了本方法
    // }
    if (call != null) call(isPermitted);

    return isPermitted;
  }

  // static Future<bool> isGrantedNotify() async {
  //   bool isPermitted =  await AppPermission.isGranted(Permission.accessNotificationPolicy,hasCancel: true);
  //   logs('isPermitted=$isPermitted');
  //   return isPermitted;
  // }

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static bool notificationsEnabled = false;

  static Future<bool> isGrantedNotify() async {
    await isAndroidPermissionGranted();

    if (!notificationsEnabled) {
      // dao.use_cam_sys;
      requestPermissionsNotify();
    }
    return notificationsEnabled;
  }

  static Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
      notificationsEnabled = granted;
    }
  }

  static Future<void> requestPermissionsNotify() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      notificationsEnabled = grantedNotificationPermission ?? false;
    }
  }

  /*
    void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        SecondPage(receivedNotification.payload),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => SecondPage(payload),
      ));
    });
  }


  Future<void> checkPermission() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var status = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (status?.didNotificationLaunchApp ?? false) {
      // handle notification tapped logic here
    }

    var settings = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.getActiveNotifications();
    if (settings == null || settings.isEmpty) {

      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
      await androidImplementation?.requestNotificationsPermission();

      var requestedSettings = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermissions();
      if (requestedSettings ?? false) {
        // handle permission granted case here
      } else {
        // handle permission denied case here
      }
    } else {
      // handle notification already enabled case here
    }
  }


  static Future<void> permissionStorageCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.videos,
      Permission.audio,
    ].request();
  }

  static Future<bool> checkPermissionStorage() async {
    bool storage = true;
    bool videos = true;
    bool photos = true;

// Only check for storage < Android 13
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt! >= 33) {
      logs('---androidInfo.version.sdkInt-0-${androidInfo.version.sdkInt}');
      // videos = await Permission.videos.request().isGranted;
      photos = await Permission.photos.request().isGranted;
      logs('---videos--${videos}');
      logs('---photos--${photos}');
    } else {
      logs('---androidInfo.version.sdkInt-1-${androidInfo.version.sdkInt}');
      storage = await Permission.storage.status.isGranted;
    }

    if (storage && videos && photos) {
      // Good to go!
      return true;
    } else {
      // crap.
      return false;
    }
  }

   */
}
