import "dart:io";
import "dart:math";
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/models/core/oss_obj.dart';
import 'package:app_kit/models/core/oss_token.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UploadOss {
  static String ossAccessKeyId = '';
  static String bucket = '';
  static String signature = '';
  static String pathName = '';
  static String policy = '';
  static String url = '';
  static int size = 0;

  static Future<void> _filetoken() async {
    if (isNil(kdao.urlUpFileToOss.isEmpty, '请配置文件上传地址')) return;
    OssToken? x = await KitService.fire<OssToken>(kdao.urlUpFileToOss, hud: true, unTap: true,isMoInAppKit: true);

    if (x != null) {
      ossAccessKeyId = x.id;
      signature = x.signature;
      pathName = x.path;
      policy = x.policy;
      url = x.url;
    }
  }

  static Future<OssObj> upload({required File file, String? fileType, Function? callback, Function? onSendProgress}) async {
    size = 0;
    file.length().then((value) => size = value);

    await _filetoken();
    BaseOptions options = BaseOptions();
    options.responseType = ResponseType.plain;

    //创建dio对象
    Dio dio = Dio(options);
    // 生成oss的路径和文件名我这里目前设置的是files/20230307/1678170194599562.mp4
    String path = "$pathName.${fileType ?? _getFileType(file.path)}";

    // logs('---path--${path}');

    // 请求参数的form对象
    FormData data = FormData.fromMap({
      "key": path,
      "policy": policy,
      "OSSAccessKeyId": ossAccessKeyId,
      "success_action_status": "200", //让服务端返回200，不然，默认会返回204
      "signature": signature,
      "contentType": "multipart/form-data",
      "file": MultipartFile.fromFileSync(file.path),
    });

    Response response;
    CancelToken uploadCancelToken = CancelToken();
    if (callback != null) callback(uploadCancelToken);
    try {
      logs('---url--$url');
      logs('---data--$data');
      // 发送请求
      response = await dio.post(url, data: data, cancelToken: uploadCancelToken, onSendProgress: (int count, int data) {
        if (onSendProgress != null) onSendProgress(count, data);
        double progress = count / data * 1.0;
        EasyLoading.instance
          ..maskColor = Colors.black.withOpacity(0.2)
          ..backgroundColor = Colors.black;
        EasyLoading.showProgress(progress, maskType: EasyLoadingMaskType.none, status: '\n${(progress * 100).toStringAsFixed(0)}%');
        if (progress >= 1) EasyLoading.dismiss();
      });
      EasyLoading.instance.backgroundColor = CC.mainColor;
      kitHideLoading();

      OssObj o = OssObj();
      o.name = path;
      o.size = size;
      o.url = '$url/$path';
      o.thumbUrl = o.url;
      o.type = _getFileType(file.path);
      o.uid = pathName;
      // 成功后返回文件访问路径
      return o;
    } catch (e) {
      EasyLoading.instance.backgroundColor = CC.mainColor;
      kitHideLoading();
      kPopSnack('上传失败');
      logs('--error-e--${e.toString()}');
      return OssObj()..url = '';
      // throw(e.hashCode);
    }
  }

  static String _getFileType(String path) {
    List<String> array = path.split(".");
    return array[array.length - 1];
  }

  /*
  * 生成固定长度的随机字符串
  * */
  static String _getRandom(int num) {
    String alphabet = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    String left = "";
    for (var i = 0; i < num; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  /*
  * 根据图片本地路径获取图片名称
  * */
  static String _getImageNameByPath(String filePath) {
    // ignore: null_aware_before_operator
    return filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
  }

  /// 获取日期
  static String _getDate() {
    DateTime now = DateTime.now();
    return "${now.year}${now.month}${now.day}";
  }

  // 获取plice的base64
  static _getSplicyBase64(String policyText) {
    //进行utf8编码
    List<int> policyText_utf8 = utf8.encode(policyText);
    //进行base64编码
    String policy_base64 = base64.encode(policyText_utf8);
    return policy_base64;
  }
}
