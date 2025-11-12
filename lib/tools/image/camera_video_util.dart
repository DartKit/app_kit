import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CameraVideoUtil {
  static final CameraVideoUtil _singleton = new CameraVideoUtil._internal();

  factory CameraVideoUtil() => _singleton;

  CameraVideoUtil._internal();

  static final ImagePicker _picker = ImagePicker();

  // static Future<List<String>> pickMulitImage(context) async {
  //   final List<AssetEntity>? pickedAssets =
  //       await AssetPicker.pickAssets(context);
  //
  //   if (pickedAssets == null) return [];
  //
  //   List<String> listImgPath = [];
  //   for (var asset in pickedAssets) {
  //     final originFile = await asset.originFile;
  //     final filePath = originFile?.path;
  //     final type = asset.type;
  //     if (filePath != null) {
  //       if (type == AssetType.image) {
  //         listImgPath.add(filePath);
  //       }
  //     }
  //   }
  //
  //   return listImgPath;
  // }

  static Future<List<String>> pickMultipleImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    List<String> listImg = [];
    images?.forEach((element) {
      listImg.add(element.path);
    });

    return listImg;
  }

  static pickSingleImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    return photo?.path;
  }

  static captureAPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    return photo?.path;
  }

  // static pikcAVideo() async {
  //   final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

  //   if (video != null) {
  //     bool isToBig = await _comparVideoSize(video.path);
  //     if (isToBig) {
  //       return null;
  //     }
  //   }

  //   return video?.path;
  // }

  // static captureAVideo() async {
  //   final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

  //   if (video != null) {
  //     bool isToBig = await _comparVideoSize(video.path);
  //     if (isToBig) {
  //       return null;
  //     }
  //   }

  //   return video?.path;
  // }

  ///视频大小不能超过500M
  ///1048576 1M
  // static Future<bool> _comparVideoSize(String path) async {
  //   final videoInfo = FlutterVideoInfo();
  //   VideoData? info = await videoInfo.getVideoInfo(path);
  //   if (info != null && info.filesize! > (1048576 * 500)) {
  //     BotToast.showText(text: '视频大小不能超过500M，请重新上传');
  //     return true;
  //   }
  //   return false;
  // }

  ///将Uint8List格式的图片转换为File格式
  static Future<String> saveToImage(Uint8List imageByte) async {
    var tempDir = await getTemporaryDirectory();
    var file =
        await File('${tempDir.path}/image_${DateTime.now().millisecond}.jpg')
            .create();
    file.writeAsBytesSync(imageByte);
    // print("${file.path}");
    return file.path;
  }

  //通过图片路径将图片转换成Base64字符串
  static Future image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  ///选择文件
  // static Future<List<String>> pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowMultiple: true,
  //       onFileLoading: (FilePickerStatus status) => print(status),
  //       allowedExtensions: HYFileExtensions.replaceAll(' ', '').split(','));
  //   List<String> listPath = [];
  //   result?.paths.forEach((v) {
  //     listPath.add(v!);
  //   });
  //   return listPath;
  // }

  ///获取视频缩略图 网络
  // static thumbnailNetVideo(String voidePath) async {
  //   //"http://118.178.132.220/oa/file/test/2551_20220519094636_023804.MOV",
  //   final fileName = await VideoThumbnail.thumbnailFile(
  //     video: voidePath,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight: ScreenUtil().setHeight(150).toInt(),
  //     quality: 75,
  //   );
  //   print(fileName);
  //   return fileName;
  // }

  ///获取视频缩略图 本地
  // static thumbnailFileVideo(String voidePath) async {
  //   Uint8List? fileName = await VideoThumbnail.thumbnailData(
  //     video: voidePath,
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight: ScreenUtil().setHeight(150).toInt(),
  //     quality: 75,
  //   );
  //   String voiceImg = '';
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = File(
  //       "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");

  //   if (fileName != null) {
  //     await file.writeAsBytes(fileName);
  //     voiceImg = file.path;
  //   }

  //   return voiceImg;
  // }
}
