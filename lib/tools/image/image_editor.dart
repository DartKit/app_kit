import 'dart:io';
import 'package:app_kit/core/app_colors.dart';
import 'package:app_kit/core/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class ImageEditor {
  static void fire(
    String path, {
    Function? onImageEditingComplete,
    Function(EditorMode editorMode)? onCloseEditor,
  }) {
    File f = File(path);

    var res = <File>[].obs;

    Get.to(() => ProImageEditor.file(
          f,
          // allowCompleteWithEmptyEditing: true,
          callbacks: ProImageEditorCallbacks(
            onImageEditingComplete: (Uint8List bytes) async {
              final tempDir = await getTemporaryDirectory();
              String path0 =
                  '${tempDir.path}/ima_${DateTime.now().millisecondsSinceEpoch}.png';
              File file = await File(path0).create();
              await file.writeAsBytes(bytes);
              // if(widget.callback != null) widget.callback!(_path);
              logs('---_path--$path0');
              // Navigator.pop(context,_path);
              if (onImageEditingComplete != null) onImageEditingComplete(path0);
            },
            onCloseEditor: (EditorMode editorMode) {
              if (onCloseEditor != null) onCloseEditor(editorMode);
            },
          ),


          configs: ProImageEditorConfigs(

              // icons: const ImageEditorIcons(
              //     doneIcon: Icons.done_all_rounded, undoAction: Icons.undo),
              // imageEditorTheme: ImageEditorTheme(
              //   layerInteraction: const ThemeLayerInteraction(
              //     hoverCursor: SystemMouseCursors.move,
              //   ),
              //   paintingEditor: const PaintingEditorTheme(
              //     background: C.black,
              //     initialStrokeWidth: 4.0,
              //     // initialStrokeWidth: dao.paint_width,
              //     // strokeWidthOnChanged: (x){
              //     //   dao.paint_width = x;
              //     //   kSaveDao;
              //     // }
              //   ),
              //
              //   stickerEditor: const StickerEditorTheme(),
              //   // textEditor: TextEditorTheme(),
              //   // cropRotateEditor: CropRotateEditorTheme(),
              //   // filterEditor: FilterEditorTheme(),
              //   // emojiEditor: EmojiEditorTheme(),
              //   // stickerEditor: StickerEditorTheme(),
              //   background: Colors.black,
              //   loadingDialogTheme: LoadingDialogTheme(textColor: C.mainColor),
              //   // loadingDialogTextColor: C.mainColor,
              //   uiOverlayStyle: const SystemUiOverlayStyle(
              //     statusBarColor: C.black,
              //     statusBarIconBrightness: Brightness.light,
              //     systemNavigationBarIconBrightness: Brightness.light,
              //     statusBarBrightness: Brightness.light,
              //     systemNavigationBarColor: C.black,
              //     // systemStatusBarContrastEnforced: false,
              //   ),
              // ),
              i18n: _i18n(),
              paintEditor: PaintEditorConfigs(
                  // initialStrokeWidth: dao.paint_width,
                  // strokeWidthOnChanged: (x){
                  //   dao.paint_width = x;
                  //   kSaveDao;
                  // }
                  ),
              cropRotateEditor: const CropRotateEditorConfigs(
                aspectRatios: [
                  AspectRatioItem(text: '自由宽高比', value: null),
                  AspectRatioItem(text: '原始宽高比', value: 0.0),
                  AspectRatioItem(text: '1:1', value: 1.0 / 1.0),
                  AspectRatioItem(text: '4:3', value: 4.0 / 3.0),
                  AspectRatioItem(text: '3:4', value: 3.0 / 4.0),
                  AspectRatioItem(text: '16:9', value: 16.0 / 9.0),
                  AspectRatioItem(text: '9:16', value: 9.0 / 16.0),
                  AspectRatioItem(text: '1:2', value: 1.0 / 2.0),
                  AspectRatioItem(text: '2:1', value: 2.0 / 1.0),
                  AspectRatioItem(text: '1:3', value: 1.0 / 3.0),
                  AspectRatioItem(text: '3:1', value: 3.0 / 1.0),
                ],
              ),
              helperLines: const HelperLineConfigs(
                showVerticalLine: true,
                showHorizontalLine: true,
                showRotateLine: true,
                // hitVibration: true,
              ),
              emojiEditor: EmojiEditorConfigs(),
              stickerEditor: StickerEditorConfigs(
                enabled: true,
                builder: ( Function(WidgetLayer widgetLayer) setLayer,
                    ScrollController scrollController,) {
                  if (res.isEmpty) {
                    final ImagePicker picker = ImagePicker();
// Pick multiple images.

                    picker
                        .pickMultiImage(imageQuality: 30)
                        .then((List<XFile> images) {
                      /// medias 照片路径信息 Photo path information
                      res.value =
                          images.map((e) => File(e.path ?? '')).toList();
                      if (res.isEmpty) {
                        Get.back();
                        return;
                      }
                    });

                    // ImagePickers.pickerPaths(
                    //   selectCount: 30,
                    //   showGif: true,
                    //   uiConfig: UIConfig(uiThemeColor: C.mainColor),
                    // ).then((List<Media> medias){
                    //   /// medias 照片路径信息 Photo path information
                    //   res.value = medias.map((e) => File(e.path??'')).toList();
                    //   if (res.isEmpty) {
                    //     Get.back();
                    //     return;
                    //   }
                    // });
                  }

                  return ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      color: const Color.fromARGB(255, 224, 239, 251),
                      child: Obx(() => GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: res.length + (res.isEmpty ? 0 : 1),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index != res.length) {

                                Widget widget = ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.file(
                                    res[index],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                );
                                return GestureDetector(
                                  onTap: () => setLayer(WidgetLayer(widget: widget)),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: widget,
                                  ),
                                );
                              }

                              return InkWell(
                                onTap: () {
                                  final ImagePicker picker = ImagePicker();
                                  picker
                                      .pickMultiImage(imageQuality: 30)
                                      .then((List<XFile> images) {
                                    /// medias 照片路径信息 Photo path information
                                    List<File> ls = images
                                        .map((e) => File(e.path ?? ''))
                                        .toList();
                                    if (ls.isEmpty) {
                                      Get.back();
                                      return;
                                    }
                                    res.addAll(ls);
                                  });

                                  // ImagePickers.pickerPaths(
                                  //   selectCount: 30,
                                  //   showGif: true,
                                  //   uiConfig: UIConfig(uiThemeColor: C.mainColor),
                                  // ).then((List<Media> medias){
                                  //  List<File> ls =  medias.map((e) => File(e.path??'')).toList();
                                  //   if (ls.isEmpty) {
                                  //     Get.back();
                                  //     return;
                                  //   }
                                  //  res.addAll(ls);
                                  // });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border:
                                        Border.all(width: 1.r, color: C.line),
                                  ),
                                  width: 120,
                                  height: 120,
                                  child: Icon(
                                    Icons.add_photo_alternate_rounded,
                                    size: 60,
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  );
                },
              )),
        ));
  }

  static I18n _i18n() {
    return I18n(
      cancel: '取消',
      undo: '上一步',
      redo: '下一步',
      done: '完成',
      remove: '移除',
      doneLoadingMsg: '处理中...',
      various: I18nVarious(
        loadingDialogMsg: '请等待...',
        closeEditorWarningTitle: '关闭图片编辑?',
        closeEditorWarningMessage: '您要关闭编辑吗? 如图退出您所有的修改将不会被保存！',
        closeEditorWarningConfirmBtn: '确定',
        closeEditorWarningCancelBtn: '取消',
      ),
      paintEditor: I18nPaintEditor(
        bottomNavigationBarText: '涂鸦',
        freestyle: '书写',
        arrow: '箭头',
        line: '线',
        rectangle: '方形',
        circle: '圆形',
        dashLine: '虚线',
        lineWidth: '线宽',
        toggleFill: '填充',
        undo: '上一步',
        redo: '下一步',
        done: '完成',
        back: '返回',
        eraser: '橡皮擦',
        changeOpacity: '透明度',
        smallScreenMoreTooltip: '更多',
      ),
      textEditor: I18nTextEditor(
        inputHintText: '请您输入要添加的文本',
        bottomNavigationBarText: '文字',
        back: '返回',
        done: '完成',
        textAlign: '对齐',
        fontScale: '字体缩放',
        backgroundMode: '背景模式',
        smallScreenMoreTooltip: '更多',
      ),
      blurEditor: I18nBlurEditor(
        // applyBlurDialogMsg : '正在模糊虚化...',
        bottomNavigationBarText: '模糊',
        back: '返回',
        done: '完成',
      ),
      emojiEditor: I18nEmojiEditor(
        bottomNavigationBarText: '表情',
        search: '搜索',
        categoryRecent: '最近使用',
        categorySmileys: '笑脸和人物',
        categoryAnimals: '动物和自然',
        categoryFood: '食品和饮料',
        categoryActivities: '活动',
        categoryTravel: '旅行和地点',
        categoryObjects: '物体',
        categorySymbols: '符号',
        categoryFlags: '旗帜',
      ),
      tuneEditor: I18nTuneEditor(
        bottomNavigationBarText: '调色',
        back: '返回',
        done: '完成',
        brightness: '亮度',
        contrast: '对比度',
        saturation: '饱和度',
        exposure: '曝光度',
        hue: '色调',
        temperature: '色温',
        sharpness: '锐度',
        fade: '淡化',
        luminance: '辉度',
        undo: '上一步',
        redo: '下一步',
      ),
      cropRotateEditor: I18nCropRotateEditor(
        bottomNavigationBarText: '裁剪/旋转',
        rotate: '旋转',
        flip: '翻转',
        reset: '重置',
        ratio: '宽高比',
        back: '返回',
        done: '完成',
        // aspectRatioFree : '自由宽高比',
        // aspectRatioOriginal : '原始宽高比',
        // prepareImageDialogMsg : '请等待',
        // applyChangesDialogMsg : '请等待',
        smallScreenMoreTooltip: '更多',
      ),
      filterEditor: I18nFilterEditor(
        // applyFilterDialogMsg: '处理滤镜...',
        bottomNavigationBarText: '滤镜',
        back: '返回',
        done: '完成',
        filters: const I18nFilters(
          // none : '无滤镜',
          addictiveBlue: 'AddictiveBlue',
          addictiveRed: 'AddictiveRed',
          aden: 'Aden',
          amaro: 'Amaro',
          ashby: 'Ashby',
          brannan: 'Brannan',
          brooklyn: 'Brooklyn',
          charmes: 'Charmes',
          clarendon: 'Clarendon',
          crema: 'Crema',
          dogpatch: 'Dogpatch',
          earlybird: 'Earlybird',
          f1977: '1977',
          gingham: 'Gingham',
          ginza: 'Ginza',
          hefe: 'Hefe',
          helena: 'Helena',
          hudson: 'Hudson',
          inkwell: 'Inkwell',
          juno: 'Juno',
          kelvin: 'Kelvin',
          lark: 'Lark',
          loFi: 'Lo-Fi',
          ludwig: 'Ludwig',
          maven: 'Maven',
          mayfair: 'Mayfair',
          moon: 'Moon',
          nashville: 'Nashville',
          perpetua: 'Perpetua',
          reyes: 'Reyes',
          rise: 'Rise',
          sierra: 'Sierra',
          skyline: 'Skyline',
          slumber: 'Slumber',
          stinson: 'Stinson',
          sutro: 'Sutro',
          toaster: 'Toaster',
          valencia: 'Valencia',
          vesper: 'Vesper',
          walden: 'Walden',
          willow: 'Willow',
          xProII: 'X-Pro II',
        ),
      ),
      stickerEditor: I18nStickerEditor(
        bottomNavigationBarText: '叠加',
      ),
    );
  }
}
