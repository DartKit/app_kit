import 'dart:io';
import 'package:app_kit/core/app_device.dart';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/core/app_permission.dart';
import 'package:app_kit/generated/assets.dart';
import 'package:app_kit/models/core/common_ver.dart';
import 'package:app_kit/tools/ast_tool_kit.dart';
import 'package:app_kit/utils/open_file.dart';
import 'package:app_kit/widgets/kit_views/kit_view.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionUpdated extends StatefulWidget {
  CommonVerVersion mo;
  bool is_force;
  String url;
  Function onClickInstall;
  VersionUpdated({super.key, required this.mo, required this.is_force, required this.url,required this.onClickInstall});

  static Future<bool> haveNewVersion(String newVersion) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    String curent = info.version;

    if (newVersion.isEmpty || curent.isEmpty) return false;

    int newVersionInt, oldVersion;
    var newList = newVersion.split('.');
    var oldList = curent.split('.');
    if (newList.isEmpty || oldList.isEmpty) return false;

    for (int i = 0; i < newList.length; i++) {
      newVersionInt = int.parse(newList[i]);
      oldVersion = int.parse(oldList[i]);
      if (newVersionInt > oldVersion) {
        return true;
      } else if (newVersionInt < oldVersion) {
        return false;
      }
    }
    return false;
  }

  static Future<void> getVersion({bool isHud = false, required url, required int owm_project_id , required Function onClickInstall}) async {
    Map<String, dynamic> map = {
      // 'channel': isDebug ? kdao.official : kdao.channel,
      'channel': kdao.channel,
      // if(dao.isLogin) 'project':dao.own.project.id
    };
    if ((kdao.channel == 'official') || ((kdao.channel == 'appstore'))) map.clear();
    logs('---kdao.channel--${kdao.channel}');

    CommonVer? res = await KitService.fireGet<CommonVer>(url, query: map,isMoInAppKit: true);
    if (res != null) {
      if (res.info.project_list.contains(owm_project_id) == false) {
        if (isHud) kPopSnack('当前已是最新版本', bgColor: CC.blue);
        return;
      }
      ChannelVer gw = ChannelVer()
        ..channel = 'official'
        ..name = '官网';
      if (res.info.url.isNotEmpty) gw.url = res.info.url.first.url;

      int newV = res.info.code;
      bool is_force = res.info.force_format;
      if (Platform.isIOS) {
        newV = res.info.ios_code;
        is_force = res.info.ios_force_format;
        gw.channel = 'appstore';
      }
      res.info.channels.add(gw);
      logs('---AppDevice.versionCode--${AppDevice.versionCode}---newV--$newV');
      if (newV > AppDevice.versionCode) {
        AppDevice.has_version = true;
        for (var o in res.info.channels) {
          logs('---o.channel--${o.channel}---kdao.channel--${kdao.channel}');
          if (o.channel == kdao.channel) _showNewVersionUpdated(res.info, is_force, o.url,onClickInstall: onClickInstall);
        }
      } else {
        if (isHud) kPopSnack('当前已是最新版本', bgColor: CC.blue);
      }
    }
  }

  // static Future<String> getVersionFromAppStore() async {
  //   String? versionName = await RUpgrade.getVersionFromAppStore(AppKey.appStoreId);
  //   logs(versionName);
  //   return  versionName??'';
  // }

  static Future<void> _showNewVersionUpdated(CommonVerVersion mo, bool is_force, url,{required Function onClickInstall}) async {
    logs('---o.url--$url');
    return showDialog(
      context: Get.context!,
      barrierDismissible: is_force,
      builder: (BuildContext context) {
        return VersionUpdated(mo: mo, is_force: is_force, url: url,onClickInstall: onClickInstall,);
      },
    );
  }

  @override
  _VersionUpdatedState createState() => _VersionUpdatedState();
}

class _VersionUpdatedState extends State<VersionUpdated> {
  final CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  var _value = (0.0).obs;
  var _path = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value.value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// 使用false禁止返回键返回，达到强制升级目的
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            padding: EdgeInsets.only(left: 30.r, right: 30.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 155.r,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                    image: DecorationImage(image: AssetImage(AstToolKit.pkgAst(AstKit.lib_asts_images_up_ver)), fit: BoxFit.fill),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "线上版本：v${isIOS ? widget.mo.ios_version : widget.mo.version}",
                              style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w600, fontSize: 14.r),
                            ),
                          ],
                        ),
                      ),
                      if (kdao.hostUrls.isNotEmpty)
                        if (!kdao.baseUrl.contains(kdao.hostUrls[0]))
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Top2Text('当前为测试环境，请谨慎更新！', color: Color(0xff000000), fontSize: 14.r),
                          ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: .0), child: buildColumn()),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 15.0),
                        child: _isDownload
                            ? Container(
                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: Obx(() {
                                  return Column(
                                    children: [
                                      LinearProgressIndicator(backgroundColor: const Color(0xffcccccc), valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue), value: _value.value),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.r, bottom: 20.r),
                                        child: Text(
                                          '已下载: ${(_value * 100).toStringAsFixed(1)} %',
                                          style: const TextStyle(color: Color(0xff3695ff), fontSize: 12.0, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      if (_value.value == 1)
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(CC.lightBlack),
                                                      shape: MaterialStateProperty.all(
                                                        const StadiumBorder(
                                                          side: BorderSide(style: BorderStyle.solid, color: CC.lightBlack),
                                                        ),
                                                      ), //圆角弧度
                                                    ),
                                                    onPressed: () async {
                                                      logs('---_path--$_path');
                                                      await OpenFile.open(_path).then((value) => print('value == ${value.message}'));
                                                      widget.onClickInstall();
                                                    },
                                                    child: const Text(
                                                      '立即安装',
                                                      style: TextStyle(color: Color(0xff3695ff), fontSize: 13.0, fontWeight: FontWeight.w700),
                                                    ),
                                                  ).marginOnly(top: 0.r, bottom: 10.r),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '升级需按引导授权《数字园林》安装此来源未知应用',
                                              style: TextStyle(color: CC.black, fontSize: 11.r, fontWeight: AppFont.regular),
                                            ),
                                          ],
                                        ),
                                    ],
                                  );
                                }),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  if (widget.is_force == false)
                                    Container(
                                      width: 110.0,
                                      margin: EdgeInsets.only(right: 30),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(CC.lightBlack),
                                          shape: MaterialStateProperty.all(
                                            const StadiumBorder(
                                              side: BorderSide(style: BorderStyle.solid, color: CC.lightBlack),
                                            ),
                                          ), //圆角弧度
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          '拒绝更新',
                                          style: TextStyle(color: Color(0xff3695ff), fontSize: 13.0, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    width: 110.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(const Color(0xff3695ff)),
                                        shape: MaterialStateProperty.all(
                                          const StadiumBorder(
                                            side: BorderSide(style: BorderStyle.solid, color: Color(0xff3695ff)),
                                          ),
                                        ), //圆角弧度
                                      ),
                                      onPressed: () async {
                                        if (defaultTargetPlatform == TargetPlatform.iOS) {
                                          await launchUrl(Uri.parse(kdao.appStoreUrl));
                                        } else {
                                          if (kdao.channel == kdao.official) {
                                            // _isDownload = true;
                                            // if (mounted) setState(() {});
                                            _download();
                                          } else {
                                            if (isNil(widget.url, '当前无${kdao.channel}平台的下载地址,\n请到应用商店下载新版本')) return;
                                            bool can = await canLaunchUrl(Uri.parse(widget.url));
                                            if (can) await launchUrl(Uri.parse(widget.url));
                                          }
                                        }
                                      },
                                      child: const Text(
                                        '立即更新',
                                        style: TextStyle(color: CC.white, fontSize: 13.0, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    List remark = widget.mo.remark;
    List<Widget> list = [];
    if (remark.isNotEmpty) {
      for (int i = 0; i < remark.length; i++) {
        list.add(Text(remark[i].toString(), style: const TextStyle(color: Color(0xff333333), fontSize: 14.0)));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  // ///下载apk
  _download() async {
    try {
      // bool hasStorage = (await Permission.manageExternalStorage.isGranted) && (await Permission.storage.isGranted);
      // bool hasStorage = (await Permission.manageExternalStorage.isGranted);
      PermissionStatus st1 = await Permission.manageExternalStorage.request();
      bool hasStorage = AppPermission().hasGotPermission(st1);
      if (!hasStorage) {
        KitView.alert(
          title: '版本升级',
          content: '软件升级需相关的访问和存储权限!\n请您按照权限申请引导授权后操作!',
          noCancel: true,
          sure: () async {
            PermissionStatus st1 = await Permission.manageExternalStorage.request();
            // PermissionStatus st2 = await Permission.storage.request();
            // if (st1 == PermissionStatus.granted && st2 == PermissionStatus.granted) hasStorage = true;
            if ((st1 == PermissionStatus.granted) || (st1 == PermissionStatus.restricted) || (st1 == PermissionStatus.limited)) hasStorage = true;
          },
        );
      }

      logs('---hasStorage--$hasStorage');
      if (hasStorage) {
        _isDownload = true;
        if (mounted) setState(() {});
        var savePath = await CoOpenFile.savePath(widget.url);
        var response = await Dio().get(
          widget.url,
          onReceiveProgress: (int count, int total) {
            if (total != 0) {
              _value.value = count / total;
            }
          },
          options: Options(responseType: ResponseType.bytes),
        );
        if (_value.value == 1) {
          File file = File(savePath);
          var raf = file.openSync(mode: FileMode.write);
          // response.data is List<int> type
          raf.writeFromSync(response.data);
          await raf.close();
          _path = savePath;
          logs('---_path--$_path');
        }
        // File file = File(savePath);
        // logs('---file--${file.path}');
      }

      // bool f = true;
      /*
      if (f) {
        id = await RUpgrade.upgrade(widget.mo.file_url,
            fileName: 'app-release.apk', notificationStyle: NotificationStyle.speechAndPlanTime, installType: RUpgradeInstallType.normal, useDownloadManager: true);
        RUpgrade.stream.listen((DownloadInfo info) {
          double? percent = info.percent;
          logs('---info--$info');
          if (info.status == DownloadStatus.STATUS_SUCCESSFUL) {
            _value.value = 1;
            logs('---info.path--${info.path}');
            _path = info.path ?? '';
            if (mounted) setState(() {});
            // Future.delayed(Duration(milliseconds: 3000),(){
            //   Get.back();
            // });
            return;
          }
          logs('---percent--$percent');
          if (percent != null) {
            if (percent < 100) {
              _speed.value = info.speed ?? 0;
              _value.value = percent / 100;
            }
          }
        });
      }
      */
    } catch (e) {
      logs('--更新失败-e--$e');
      kitPopText('更新失败，请稍后再试');
    }
  }

  /*
  // ///下载apk
  _download() async {
    try {
      // bool f = await AppPermission.isGranted(Permission.storage);
      bool f = true;
      if(f) {
        id = await RUpgrade.upgrade(
            widget.mo.url.first.url,
            fileName: 'app-release.apk',
            notificationStyle: NotificationStyle.speechAndPlanTime,
            installType: RUpgradeInstallType.normal,
            useDownloadManager: true
        );
        RUpgrade.stream.listen((DownloadInfo info){
          double? percent = info.percent;
          logs('---info--$info');
          if (info.status == DownloadStatus.STATUS_SUCCESSFUL) {
            _value = 1;
            if (mounted) setState(() {});
            Future.delayed(Duration(milliseconds: 3000),(){
              Get.back();
            });
            return;
          }
          logs('---percent--$percent');
          if (percent != null) {
            if (percent < 100) {
              _value = percent / 100;
              _speed = info.speed??0;
              if (mounted) setState(() {});
            }
          }
        });
      }
    } catch (e) {
      logs('--更新失败-e--$e');
      kitPopText('更新失败，请稍后再试');
    }
  }
  */
}
