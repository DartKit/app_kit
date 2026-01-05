// import 'dart:html';
import 'dart:io';
import 'package:app_kit/core/app_log.dart';
import 'package:app_kit/core/app_permission.dart';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/models/core/oss_obj.dart';
import 'package:app_kit/tools/image/oss.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:image_pickers/image_pickers.dart';
// import 'package:image_pickers/image_pickers.dart';

class UploadIma {
  static Future<OssObj> uploadFile_rspOss(
    File file,
  ) async {
    final OssObj url = await UploadOss.upload_rspOss(file: file);
    return url;
  }

  static Future<OssObj> fire_rspOss() async {
    OssObj oss = OssObj();
    final ImagePicker picker = ImagePicker();
    final XFile? res = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    // List<Media> res = await ImagePickers.pickerPaths(
    //   galleryMode: GalleryMode.image,
    //   selectCount: 1,
    //   showGif: true,
    //   showCamera: false,
    //   compressSize: 300,
    //   uiConfig: UIConfig(uiThemeColor: CC.mainColor),
    //   cropConfig: CropConfig(enableCrop: true, width: 1, height: 1)
    // );

    if (res != null) {
      // List ls = res.map((e) => e.path).toList();
      String ph = res.path ?? '';
      logs('---ph--$ph');
      if (ph.isNotEmpty) oss = await uploadFile_rspOss(File(ph));
    }
    return oss;
  }


  static Future<String> uploadFile_rspStr({File? file,String filePath = '',bool showHud = true}) async {
    final String oss = await UploadOss.upload_rspStr(file: file,filePath: filePath,showHud: showHud);
    return oss;
  }


  static Future<String> fire_rspStr({bool enableCrop = false,unOss = false,ImageSource source = ImageSource.gallery}) async {
    String oss = '';
    bool f = false;
    f =  await AppPermission.isGranted( Permission.photos);
    if (f) {

      final ImagePicker picker = ImagePicker();
      List<XFile> res = [];

      final XFile? media = await picker.pickImage(
        source: source,
        imageQuality: 30,
      );
      if (media != null) res.add(media);
      if (res.isNotEmpty) {
        // List ls = res.map((e) => e.path).toList();
        String ph = res.first.path;
        logs('---ph--$ph');
        if(ph.isNotEmpty) {
          if (unOss) {
            oss = ph;
          }else {
            oss = await uploadFile_rspStr(filePath: ph);
          }
        }
      }
      logs('---oss--$oss');
    }
    return oss;
  }

  static void sheetSelect({Function(String url)? callOneCamera,Function(String url)? callOneImage} ) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      context: Get.context!,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _sheetCell(isCamera: true, callback: () async {
                bool f = false;
                f =  await AppPermission.isGranted( Permission.camera);
                logs('---f--$f');
                if (f == true) {
                  final ImagePicker picker = ImagePicker();
                  final XFile? res = await picker.pickImage(source: ImageSource.camera,imageQuality: 30);
                  // Media? res = await ImagePickers.openCamera();
                  if (res != null && (res.path.isNotEmpty)) {
                    logs('---image.path--$res');
                    var oss = await uploadFile_rspStr(filePath: res.path);
                    logs('---oss--$oss');

                    if (callOneCamera != null && oss.isNotEmpty)  callOneCamera(oss);
                  }
                }

              }),
              _sheetCell(isCamera: false, showLine: false, callback: () async {
                bool f = false;
                f =  await AppPermission.isGranted( Permission.photos);
                logs('---f--$f');
                if (f == true) {
                  final ImagePicker picker = ImagePicker();
                  List<XFile> res = [];
                  final XFile? media = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 30,
                  );
                  if (media != null) res.add(media);
                  // List<Media> res = await ImagePickers.pickerPaths(
                  //   selectCount: 1,
                  //   showGif: true,
                  //   showCamera: false,
                  //   compressSize: 300,
                  //   uiConfig: UIConfig(uiThemeColor: C.FF3BC58B),
                  //   cropConfig: null,
                  // );
                  if (res.isNotEmpty && (res.last.path.isNotEmpty)) {
                    logs('---image.path--$res');
                    String oss = await uploadFile_rspStr(filePath: res.last.path);
                    logs('---oss--$oss');
                    if (callOneImage != null && oss.isNotEmpty) callOneImage(oss);

                  }
                  // List<Media> res = await ImagePickers.pickerPaths(
                  //     galleryMode: GalleryMode.image,
                  //     selectCount: 1,
                  //     showGif: true,
                  //     showCamera: false,
                  //     compressSize: 300,
                  //     uiConfig: UIConfig(uiThemeColor: C.FF3BC58B),
                  //     cropConfig: CropConfig(enableCrop: enableCrop, width: 1, height: 1)
                  // );
                  //
                  // if (res.isNotEmpty) {
                  //   // List ls = res.map((e) => e.path).toList();
                  //   String ph = res.first.path??'';
                  //   logs('---ph--$ph');
                  //   if(ph.isNotEmpty) oss = await uploadFile(filePath: ph);
                  // }
                }
              }),
            ],
          ),
        );
      },
    );
  }

  static  Widget _sheetCell(
      {bool isCamera = true, bool showLine = true, required var callback}) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isCamera ? Icons.photo_camera : Icons.photo),
              SizedBox(
                width: 15,
              ),
              Text(isCamera ? '相机拍照' : '相册选择'),
            ],
          ),
          onTap: () async {
            bool f = false;
            f =  await AppPermission.isGranted( isCamera ? Permission.camera : Permission.photos);
            logs('---f--$f');
            if (f) {
              Navigator.pop(Get.context!);
              callback();
            }
          },
        ),
        showLine ? const Divider() : Container(),
      ],
    );
  }


  // static Future<bool?> imageSafeCheck(String url) async {
  //   Map<String,dynamic> map = {
  //     'image_url':url,
  //   };
  //   bool? res = await CoService.fire<bool>(Url.imageCheck,data: map,hud: false);
  //   logs('---res--$res');
  //   return res;
  // }
}
