import 'dart:io';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/core/app_permission.dart';
import 'package:app_kit/generated/assets.dart';
import 'package:app_kit/models/core/oss_obj.dart';
import 'package:app_kit/tools/ast_tool_kit.dart';
import 'package:app_kit/tools/image/camera.dart';
import 'package:app_kit/tools/image/image_editor.dart';
import 'package:app_kit/utils/open_file.dart';
import 'package:app_kit/tools/image/oss.dart';
import 'package:app_kit/tools/image/gallery.dart';
import 'package:app_kit/widgets/kit_views/kit_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:image_pickers/image_pickers.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

var aiGif = false.obs;

enum TypePicker {
  image_camera(0, 'image_camera'),
  image(1, 'image'),
  camera(2, 'camera');

  const TypePicker(this.number, this.text);
  final int number;
  final String text;
  static TypePicker name(String title) => TypePicker.values.firstWhereOrNull((e) => e.name == title) ?? TypePicker.camera;
}

class PhotoPicker extends StatefulWidget {
  PhotoPicker({
    super.key,
    this.type = TypePicker.image_camera,
    this.margin,
    this.max = 9,
    this.compressSize = 500,
    this.title = '问题图片（最多9张）',
    this.hintText = '',
    this.is_required = false,
    this.titleStyle,
    this.callback,
    this.bgColor,
    this.bdColor,
    this.isLook = false,
    this.isWrap = false,
    this.imaAndVideo = false,
    // this.isBig = false,
    this.wrapAlignment,
    this.check_box,
    this.onCheckBoxChange,
    this.urls,
    this.isFile = false,
    this.aiCall,
    this.isUpLsInStr = false,
    this.canImaEdit = false,
    this.canCamEdit = false,
    this.useCamSys = true,
    this.holder,
    this.circular,
    this.imaSizeW,
    this.imaSizeH,
    this.addImaTipStr,

  });
  bool isLook;
  String title;
  String hintText;
  bool is_required;
  TypePicker type;
  var callback;
  int max;
  Color? bgColor;
  Color? bdColor;
  TextStyle? titleStyle;
  List? urls;
  EdgeInsetsGeometry? margin;
  bool isWrap = false;
  WrapAlignment? wrapAlignment;
  bool? check_box;
  Function? onCheckBoxChange;
  int compressSize;
  bool imaAndVideo;
  // bool isBig;
  bool isFile;
  Function? aiCall;
  bool isUpLsInStr;
  bool canImaEdit;
  bool canCamEdit;
  bool useCamSys;
  Widget? holder;
  double? circular;
  double? imaSizeW;
  double? imaSizeH;
  String? addImaTipStr;

  // /// 已经上传成功的  图片名称。退出当前页面后清空
  // static List<String> names = [];

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  List<dynamic> _urls = [];
  int _aiIndex = -1;

  @override
  void initState() {
    super.initState();
    _setUrls();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // logs('---widget.urls-000-${widget.urls}');
  }

  @override
  void didUpdateWidget(covariant PhotoPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // logs('---widget.urls-0-${widget.urls}');
    // logs('---oldWidget.urls-0-${oldWidget.urls}');
    if (widget.urls != oldWidget.urls) {
      _setUrls();
    }
  }


  void _setUrls() {
    if ((widget.urls?.isNotEmpty == true)) {
      // _urls = widget.urls!;
      logs('---widget.urls!.first.runtimeType--${widget.urls!.first.runtimeType}');
      if (widget.urls!.first.runtimeType.toString().startsWith('_Map')) {
        _urls = widget.urls!.map((e) => OssObj.fromJson(e)).toList();
      } else {
        if (widget.urls!.first.runtimeType == String) {
          _urls = widget.urls!.map((e) => OssObj()..url = e).toList();
        } else {
          _urls = List<OssObj>.from(widget.urls!);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    if (widget.urls == null) return SizedBox();
    if (widget.isLook && (widget.urls != null) && (widget.urls!.isEmpty)) {
      return SizedBox();
    }
    return Container(
      margin: widget.margin ?? EdgeInsets.only(top: 5.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isEmpty
              ? Container()
              : Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      if (widget.is_required)
                        Text(
                          '∗',
                          style: TextStyle(color: CC.red, fontSize: 16.r, fontWeight: FontWeight.w700),
                        ),
                      if (widget.check_box != null)
                        SizedBox(
                          height: 20.r,
                          width: 30.r,
                          child: Checkbox(
                              value: widget.check_box,
                              onChanged: (x) {
                                _check_box_fire();
                              }),
                        ),
                      Expanded(
                        child: InkWell(
                          onTap: _check_box_fire,
                          child: Text(
                            widget.title + (widget.isLook ? '' : '（最多${widget.max}张）'),
                            style: widget.titleStyle ?? TextStyle(color: CC.deepBlack, fontSize: 16.r, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          if (widget.check_box != false) _buildUploadContainer()
        ],
      ),
    );
  }

  Future<void> _check_box_fire() async {
    if (widget.check_box != null) widget.check_box = !widget.check_box!;
    if (widget.check_box == false) _urls.clear();
    if (mounted) setState(() {});
    if (widget.onCheckBoxChange != null) widget.onCheckBoxChange!(widget.check_box);
  }

  Widget _buildUploadContainer() {
    List<Widget> list = [];
    if (_urls.isNotEmpty) {
      for (int i = 0; i < _urls.length; i++) {
        list.add(_cellIma(i));
      }
    }
    if (!widget.isLook) {
      _urls.length >= widget.max ? SizedBox() : list.add(_add());
    }

    return widget.isWrap
        ? Container(
            // color: CC.random,
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    alignment: widget.wrapAlignment ?? WrapAlignment.start,
                    spacing: 10.r,
                    runSpacing: 10.r,
                    children: list,
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
      height: widget.imaSizeH ?? imaSizeW,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: list.map((e) => e.marginOnly(right: 10.r)).toList(),
            ),
          );
  }

  Widget _add() {
    return InkWell(
        onDoubleTap: _uploadCameraImage,
        onLongPress: _uploadCameraImage,
        onTap: () async {
          logs('---widget.type-3-${widget.type}');
          Get.focusScope!.unfocus();
          if (widget.isFile) {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['zip', 'rar', 'pdf', 'doc', 'xls', 'txt', 'png', 'jpg', 'jpeg'],
            );
            if (result != null) {
              // File file = File(result.files.single.path!);
              if (result.files.single.path?.isNotEmpty == true) _getPathToOss([result.files.single.path]);
            } else {
              // User canceled the picker
            }
            return;
          }
          if (widget.type == TypePicker.image_camera) {
            _sheetSelect();
          } else if (widget.type == TypePicker.image) {
            _uploadPickImage();
          } else if (widget.type == TypePicker.camera) {
            _uploadCameraImage();
          }
        },
        child: Container(
          width: imaSizeW,
          height: widget.imaSizeH ?? imaSizeW,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(border: Border.all(color: widget.bdColor ?? CC.fiveColor), borderRadius: BorderRadius.all(Radius.circular(widget.circular??5.r)), color: widget.bgColor ?? CC.white),
          child: Column(
            spacing: 3.r,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.isFile ? Icons.upload_file_sharp : Icons.photo_camera,
                color: CC.fiveColor,
                size: 40.r,
              ),
             if (widget.hintText.isNotEmpty)  Text(widget.hintText, style: TextStyle(color: Color(0xFF666666), fontSize: 12.r, fontWeight: AppFont.bold),),
            ],
          ),
        ));
  }

  Widget _cellIma(index) {
    var ob = _urls[index];
    var url =  ob.runtimeType == String ? ob: ob.url;

    // var mo = _urls[index];
    // logs('--mo.name--:${mo.name}');
    var end = ((url.split('.').last).split('?x').first).toLowerCase();
    // logs('--end--:${end}');

    return SizedBox(
      width: imaSizeW,
      // margin: EdgeInsets.only(right: 10.r),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ['jpg', 'jpeg', 'png', 'webp', 'heic', 'jfif', 'gif', 'bmp', 'tiff', 'ai', 'cdr', 'eps', 'svg'].contains(end)
                ? InkWell(
                    onTap: () {
                      // ImagePickers.previewImages(_urls.map((e) => e.url).toList(), index);
                      gotoImagesView(urls: _urls, index: index);
                      // Get.to(()=>GalleryPhotoViewWrapper(
                      //   galleryItems: _urls,
                      //   initialIndex: index,
                      // ));
                    },
                    child: CoImage(
                      url,
                      width: imaSizeW, height: widget.imaSizeH ?? imaSizeW,
                      fit: BoxFit.cover,
                      circular: widget.circular??5.r,
                    ))
                : _file(ob.runtimeType == String? (OssObj()..url = url) : ob ),
          ),
          if (widget.aiCall != null)
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Obx(() => (aiGif.isTrue && (_aiIndex == index))
                    ? SizedBox()
                    : InkWell(
                        child: Container(
                          height: 30.r,
                          decoration: BoxDecoration(
                            color: CC.blue.withOpacity(0.7),
                            borderRadius: BorderRadius.all(Radius.circular(4.r)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'AI 识图',
                                style: TextStyle(color: CC.white, fontSize: 14.r, fontWeight: AppFont.regular),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          aiGif.value = true;
                          _aiIndex = index;
                          if (widget.aiCall != null) {
                            widget.aiCall!(url);
                          }
                        },
                      ))),
          Obx(() => (aiGif.isTrue && (_aiIndex == index)) ? Positioned(top: 0, right: 0, left: 0, bottom: 0, child: CoImage(AstToolKit.pkgAst(AstKit.lib_asts_images_gf_scan1))) : SizedBox()),
          Positioned(
              top: 0.0,
              right: 0.0,
              child: Offstage(
                offstage: widget.isLook,
                child: InkWell(
                  child: Container(
                    height: 24.0,
                    width: 24.0,
                    decoration: BoxDecoration(
                      color: CC.mainColor.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 18.0,
                    ),
                  ),
                  onTap: () {
                    aiGif.value = false;
                    _urls.removeAt(index);
                    if (widget.callback != null) {

                        // List ls = [];
                        // for (var e in _urls) {
                        //   if (e.runtimeType == String) {
                        //     ls.add(e);
                        //   } else {
                        //     ls.add(widget.isUpLsInStr? e.url:e);
                        //   }
                        // }
                      List ls = _urls.map((e) => widget.isUpLsInStr? e.url: e).toList();
                      widget.callback(ls);
                    }
                    if (mounted) setState(() {});
                  },
                ),
              )),
        ],
      ),
    );
  }

  String get timestamp => DateTime.now().millisecondsSinceEpoch.toString();
  // double get imaSize => (Get.width - 20.r - 35.r - (widget.isLook ? 0 : 30.r) - 10.r * 2) / 3.0;
  double get imaSizeW => widget.imaSizeW ?? (Get.width - 20.r - 35.r - (widget.isLook ? 0 : 30.r) - 10.r * 2) / 3.0;

  Widget _file(OssObj mo) {
    return Stack(
      children: [
        InkWell(
            onTap: () async {
              CoOpenFile.open(url: mo.url);
            },
            child: Container(
              padding: EdgeInsets.all(5.r),
              width: imaSizeW,
              height: widget.imaSizeH??imaSizeW,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(width: 1.r, color: CC.line), color: CC.lightGrey.withOpacity(0.3)),
              child: AutoSizeText(
                '\n' + mo.name.ifNil(mo.url.split('/').last),
                // style: TextStyle(fontSize: 18.r),
                // minFontSize: 8,
                // maxFontSize: 28,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            )),
        Align(
          alignment: Alignment.topLeft,
          child: KitView.sortName((mo.name.ifNil(mo.url)).split('.').last, padding: EdgeInsets.symmetric(vertical: 1.r, horizontal: 5.r), bgColor: CC.mainColor.withOpacity(0.5), margin: EdgeInsets.all(1.5)),
        ),
      ],
    );
  }

  Widget _sheetCell({bool isCamera = true, bool showLine = true, required var callback}) {
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
            f = await AppPermission.isGranted(isCamera ? Permission.camera : Permission.photos);

            // if (isAndroid) {
            //   f =  await AppPermission.isGranted( isCamera ? Permission.camera : Permission.photos);
            // }else {
            //   await AppPermission.permissionStorageCamera();
            // }
            logs('---f--$f');
            if (f) {
              Navigator.pop(context);
              callback();
            }
          },
        ),
        showLine ? const Divider() : Container(),
      ],
    );
  }

  Future<void> _uploadCameraImage() async {
    if (_urls.length >= widget.max) {
      kitPopText('最多上传${widget.max}张图片');
      return;
    }

    if (widget.useCamSys) {
      List<XFile> res = [];
      // if (isIOS) {
      //   res = (await PhotoPickerIos.openCamera()).cast<Media>();
      // }else {
      //   ///直接打开相机拍摄图片 Open the camera directly to take a picture
      //   Media? media  = await ImagePickers.openCamera();
      //   if (media != null) {
      //     res.add(media);
      //   }
      // }
      final ImagePicker picker = ImagePicker();
      final XFile? media = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 30,
      );

      // Media? media  = await ImagePickers.openCamera(compressSize: 200);
      if (media != null) {
        res.add(media);
      }
      if (res.isEmpty) return;
      List fs = [];
      for (var i = 0; i < res.length; i++) {
        // 使用示例
        XFile? compressedFile = await compressImageToTargetSize(res[i]); // 压缩到 5M
        if (compressedFile != null) {
          // 使用压缩后的图片
          fs.add(compressedFile);
        }
      }
      if (widget.canCamEdit) {
        ImageEditor.fire(fs.first.path ?? '', onImageEditingComplete: (x) {
          _getPathToOss([x]);
        }, onCloseEditor: (event) {
          Get.back();
          // _uploadCameraImage();
        });
      } else {
        List files = fs.map((e) => e.path).toList();
        _getPathToOss(files);
      }
    } else {
      Get.to(() => AppCamera())?.then((x) {
        logs('---x-xf-$x');
        if (x != null) _getPathToOss([x]);
      });
    }
  }

  Future<XFile?> compressImageToTargetSize(XFile imageFile, [int targetSizeInBytes = 5 * 1024 * 1024]) async {
    int currentSize = await imageFile.length();
    String jpgExt = imageFile.path.split('.').last.toLowerCase();
    CompressFormat format = CompressFormat.jpeg;
    switch (jpgExt) {
      case 'jpeg':
      case 'jpg':
        format = CompressFormat.jpeg;
        break;
      case 'png':
        format = CompressFormat.png;
        break;
      case 'heic':
        format = CompressFormat.heic;
        break;
      case 'webp':
        format = CompressFormat.webp;
        break;
      default:
        {
          return imageFile;
        }
    }

    double scale = 1;
    int quality = 100;
    if (currentSize <= targetSizeInBytes) {
      logs('---currentSize-0-$currentSize');
      return imageFile; // 图片已经小于目标大小
    }

    XFile? compressedImage;
    kitHud();
    // EasyLoading.show(status:'压缩图片...',indicator: CircularProgressIndicator());
    while (currentSize > targetSizeInBytes && quality > 0) {
      // quality -= 10;
      scale = targetSizeInBytes / currentSize;
      var quality2 = (scale * 100).floor();
      logs('---quality--$quality---quality2--$quality2');
      if (quality2 == quality) return imageFile;
      quality = quality2;
      // var temUrl = '${imageFile.path.split('.').first+'_temp}'}.${jpgExt}';
      final tempDir = await getTemporaryDirectory();
      String temUrl = '${tempDir.path}/ima_tem_${DateTime.now().millisecondsSinceEpoch}.$jpgExt';
      logs('---temUrl--$temUrl');
      compressedImage = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        temUrl,
        quality: quality,
        minWidth: 1920 ~/ 2,
        minHeight: 1080 ~/ 2,
        format: format,
      );
      logs('---compressedImage--$compressedImage');
      if (compressedImage != null) currentSize = await compressedImage.length();
      logs('---currentSize--$currentSize');
    }
    kitHideLoading();
    return compressedImage;
  }

  Future<void> _toImageEditor(File origin) async {
    // return Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return ImageEditor(
    //       originImage: origin,
    //       //this is nullable, you can custom new file's save postion
    //       // savePath: customDirectory
    //   );
    // })).then((result) {
    //   if (result is EditorImageResult) {
    //     logs('---result.newFile.path--${result.newFile.path}');
    //     _getPathToOss([result.newFile.path]);
    //   }
    // }).catchError((er) {
    //   debugPrint(er);
    // });
  }

  Future<void> _uploadPickImage() async {
    if (_urls.length >= widget.max) {
      kitPopText('最多上传${widget.max}张图片');
      return;
    }

    List<XFile> res = [];
    final ImagePicker picker = ImagePicker();

    if (widget.imaAndVideo == true) {
      // if (isNil(widget.max - _urls.length <= 1, '最多只能上传${widget.max}张')) return;
      if (widget.max - _urls.length <= 1) {
        final XFile? image = await picker.pickMedia(imageQuality: 30);
        if (image != null) {
          res.add(image);
        }
      } else {
        res = await picker.pickMultipleMedia(
          imageQuality: 30,
          limit: widget.max - _urls.length,
        );
      }
    } else {
      logs('---widget.max - _urls.length--${widget.max - _urls.length}');

      if (widget.max - _urls.length <= 1) {
        final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
        if (image != null) {
          res.add(image);
        }
      } else {
        res = await picker.pickMultiImage(
          // imageQuality: 30,
          limit: widget.max - _urls.length,
        );
      }
    }
    // res = await ImagePickers.pickerPaths(
    //     galleryMode: widget.imaAndVideo? GalleryMode.all: GalleryMode.image,
    //     selectCount: widget.max - _urls.length,
    //     showGif: false,
    //     showCamera: false,
    //     compressSize: 300,
    //     uiConfig: UIConfig(uiThemeColor: CC.mainColor),
    //     // cropConfig: dao.can_ima_crop? CropConfig(enableCrop: true, width: 1, height: 1):null
    // );
    // List<Media> res = [];
    // res = await ImagePickers.pickerPaths(
    //     galleryMode: widget.imaAndVideo? GalleryMode.all: GalleryMode.image,
    //     selectCount: widget.max - _urls.length,
    //     showGif: false,
    //     showCamera: false,
    //     compressSize: 300,
    //     uiConfig: UIConfig(uiThemeColor: CC.mainColor),
    //     // cropConfig: dao.can_ima_crop? CropConfig(enableCrop: true, width: 1, height: 1):null
    // );

    if (res.isNotEmpty) {
      List fs = [];
      for (var i = 0; i < res.length; i++) {
        // 使用示例
        XFile? compressedFile = await compressImageToTargetSize(res[i]); // 压缩到 5M
        if (compressedFile != null) {
          // 使用压缩后的图片
          fs.add(compressedFile);
        }
      }

      logs('---fs--$fs');
      List files = fs.map((e) => e.path).toList();
      if (files.length == 1 && widget.canImaEdit) {
        ImageEditor.fire(fs.first.path ?? '', onImageEditingComplete: (x) {
          _getPathToOss([x]);
        }, onCloseEditor: (event) {
          Get.back();
        });
      } else {
        _getPathToOss(files);
      }
    }
  }

  void _getPathToOss(List files) async {
    if ((files.length + _urls.length) > widget.max) {
      kitPopText('最多上传${widget.max}张图片');
      return;
    }
    await uploadOss(files);
    List ls = _urls.map((e) => widget.isUpLsInStr? e.url: e).toList();
    widget.callback(ls);
    if (mounted) setState(() {});
  }

  ///  底部弹框选择相册 还是 相机
  void _sheetSelect() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Top2Text('小技巧：单击出现此弹窗，双击直接打开相机').marginOnly(top: 10.r),
              Divider(),
              _sheetCell(isCamera: true, callback: _uploadCameraImage),
              _sheetCell(isCamera: false, showLine: false, callback: _uploadPickImage),
            ],
          ),
        );
      },
    );
  }

  Future<OssObj> _uploadFile(File file, {Function? onSendProgress, Function? callback}) async {
    final OssObj url = await UploadOss.upload(file: file, onSendProgress: onSendProgress, callback: callback);
    return url;
  }

  Future<dynamic> uploadOss(List images) async {
    /*
    if (images.isEmpty) {
      return;
    }
    List ls = images;
    return Future(() async {
      return ls.map((e) async => await _uploadFile(File(e),
              callback: (e) {}, onSendProgress: (count, data) {}))
          .toList();
    }).then((files) {
      files.forEach((e) {logs('--filesfiles11---${e.toString()}');});
      return Future.wait<dynamic>(files).then((files) async {
        files.map((e) => _urls.add(e)).toList();
        logs('---_urls--$_urls');
        return _urls;
      }).catchError((e) {
        logs('--PhotoPicker-catchError---:${e.toString()}');
      });
    });
    */
    if (images.isEmpty) return;
    List ls = [];
    for (var i = 0; i < images.length; i++) {
      var res = await _uploadFile(File(images[i]), callback: (e) {}, onSendProgress: (count, data) {});
      if (res.url.isNotEmpty) {
        logs('--PhotoPicker-res---:${res.toString()}--res--:${res.runtimeType}');
        logs('--_urls-res---:${_urls.toString()}--_urls--:${_urls.runtimeType}');
        ls.add(res);
        _urls.add(res);
      }
    }
    logs('---_urls--$_urls');
    if (ls.isNotEmpty) return _urls;
  }
}
