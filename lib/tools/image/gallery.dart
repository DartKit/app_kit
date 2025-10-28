import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/core/app_permission.dart';
import 'package:app_kit/utils/open_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// 图片浏览

void gotoImagesView({
  int index = 0,
  required List urls,
  BuildContext? context,
  bool saveImaPromise = true,
  Widget? navAct,
}) =>
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.black,
      shape: const ContinuousRectangleBorder(),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: MediaQueryData.fromView(View.of(context)).padding.top),
          child: GalleryPhotoViewWrapper(
            galleryItems: urls,
            initialIndex: index,
            saveImaPromise: saveImaPromise,
            navAct: navAct,
          ),
        );
      },
    );

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    super.key,
    this.loadingBuilder,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
    this.saveImaPromise = true,
    this.enableRotation = true,
    this.navAct,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  // final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List galleryItems;
  final Axis scrollDirection;
  bool saveImaPromise;
  final bool enableRotation;
  final Widget? navAct;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  var _saveImaPromise = false;

  void onPageChanged(int idx) {
    currentIndex = idx;
    if (mounted) setState(() {});
    // if (index == 0) {
    //   widget.pageController.animateToPage(widget.galleryItems.length, duration: Duration(seconds: 1), curve: Curves.ease);
    // }
  }

  @override
  void initState() {
    _saveImaPromise = widget.saveImaPromise;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Container(
            color: Colors.black,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: _buildItem,
                  itemCount: widget.galleryItems.length,
                  enableRotation: widget.enableRotation,
                  gaplessPlayback: true,
                  allowImplicitScrolling: false,
                  // backgroundDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10.r),
                  //   border: Border.all(width: 1.r,color: C.line),
                  // ),
                  loadingBuilder: widget.loadingBuilder ??
                      (context, event) => Center(
                            child: SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: CircularProgressIndicator(
                                value: event == null
                                    ? 0
                                    : event.cumulativeBytesLoaded /
                                        (event.expectedTotalBytes ?? 1),
                              ),
                            ),
                          ),
                  pageController: widget.pageController,
                  onPageChanged: onPageChanged,
                  scrollDirection: widget.scrollDirection,
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "${currentIndex + 1} / ${widget.galleryItems.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        decoration: null,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      color: C.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.cancel,
                                color: C.white,
                                size: 30.r,
                              )).marginOnly(left: 10.r),
                          if (widget.saveImaPromise)
                            ActionButton(
                              '保存图片',
                              onTap: () async {
                                bool f3 = await AppPermission.isGranted(
                                    Permission.photos);
                                if (f3) {
                                  var url = _getIndexurl(currentIndex);
                                  _saveImaToGllery(url);
                                }
                              },
                            ),
                          if (widget.navAct != null) widget.navAct!,
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveImaToGllery(String url) async {
    String? res = await ImagePickers.saveImageToGallery(url.split('?').first);
    if (res != null) kPopSnack('保存成功');
    logs(res);

    // var response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    // final result = await ImageGallerySaver.saveImage(
    //     Uint8List.fromList(response.data),
    //     quality: 100,);
    // if (result['isSuccess'] == true) {
    //   kitPopText('保存成功');
    // }
  }

  String _getIndexurl(int index) {
    var item = widget.galleryItems[index];
    if (item.runtimeType == String) {
      return item;
    } else {
      return item.url;
    }
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    var url = _getIndexurl(index);
    List<String> ls = [
      'rar',
      'zip',
      'pdf',
      'xlsx',
      'xmls',
      'doc',
      'txt',
      'mp4',
      'mov',
      'avi',
      'flv'
    ];
    String ends = '';
    String endUrl = url.split('.').last.toLowerCase();
    for (var o in ls) {
      if (endUrl == o) ends = o;
    }
    if (ends.isNotEmpty) {
      widget.saveImaPromise = false;
      return PhotoViewGalleryPageOptions.customChild(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainText(
                '当前是$ends附件',
                color: C.white,
                fontSize: 14.r,
              ),
              SizedBox(
                height: 10.r,
              ),
              ActionButton(
                '查看附件',
                right: 0,
                onTap: () {
                  CoOpenFile.open(url: url);
                },
              )
            ],
          )),
          childSize: Size(300, 100));
    } else {
      widget.saveImaPromise = _saveImaPromise;
    }
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(url),
      // onTapDown: (BuildContext context,
      //     TapDownDetails details,
      //     PhotoViewControllerValue controllerValue,){
      //   logs('---details--${details}');
      //   Get.back();
      // },
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: url),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton(this.name, {super.key, this.onTap, this.right});
  final String name;
  final GestureTapCallback? onTap;
  final double? right;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(width: 1.r, color: C.white),
            color: C.black),
        padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 1.r),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.r,
          ),
        ),
      ).marginOnly(right: right ?? 15.r),
    );
  }
}
