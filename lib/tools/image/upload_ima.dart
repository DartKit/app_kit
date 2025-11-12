// import 'dart:html';
import 'dart:io';
import 'package:app_kit/core/app_log.dart';
import 'package:app_kit/models/core/oss_obj.dart';
import 'package:app_kit/tools/image/oss.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_pickers/image_pickers.dart';
// import 'package:image_pickers/image_pickers.dart';

class UploadIma {
  static Future<OssObj> uploadFile(
    File file,
  ) async {
    final OssObj url = await UploadOss.upload(file: file);
    return url;
  }

  static Future<OssObj> fire() async {
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
    //   uiConfig: UIConfig(uiThemeColor: C.mainColor),
    //   cropConfig: CropConfig(enableCrop: true, width: 1, height: 1)
    // );

    if (res != null) {
      // List ls = res.map((e) => e.path).toList();
      String ph = res.path ?? '';
      logs('---ph--$ph');
      if (ph.isNotEmpty) oss = await uploadFile(File(ph));
    }
    return oss;
  }
}
