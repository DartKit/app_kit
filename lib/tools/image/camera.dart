import 'dart:async';
import 'dart:io';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/tools/image/image_editor.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
// import 'image_editor/flutter_image_editor.dart';

List<CameraDescription> _cameras = <CameraDescription>[];

// class KitCamera {
//   static Future<String?> image_editor(String path) async {
//     var editedImagePath = await Get.to(()=> FlutterImageEditor(
//       defaultImage: File(path),
//       appBarColor: CC.mainColor,
//       bottomBarColor: CC.mainColor,
//     ));
//
//     logs('---editedImage--${editedImagePath}');
//     if (editedImagePath != null) {
//       return editedImagePath;
//     }
//     return null;
//   }
//
// }

class AppCamera extends StatefulWidget {
  AppCamera({super.key, this.onImageEditingComplete});
  Function? onImageEditingComplete;

  @override
  State<AppCamera> createState() {
    return _AppCameraState();
  }
}

void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

class _AppCameraState extends State<AppCamera>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  VoidCallback? videoPlayerListener;
  bool enableAudio = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  late AnimationController _flashModeControlRowAnimationController;
  late Animation<double> _flashModeControlRowAnimation;
  late AnimationController _exposureModeControlRowAnimationController;
  late Animation<double> _exposureModeControlRowAnimation;
  late AnimationController _focusModeControlRowAnimationController;
  late Animation<double> _focusModeControlRowAnimation;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;
  // late int _sensorOrientation;

  bool inEditor = false;

  // Future<void> _forceLandscape() async {
  //   await SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // }
  //
  // Future<void> _forcePortrait() async {
  //   await SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //   ]);
  //   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values); // to re-show bars
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    // _forceLandscape();
    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );
    _flashModeControlRowAnimation = CurvedAnimation(
      parent: _flashModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    _exposureModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );
    _exposureModeControlRowAnimation = CurvedAnimation(
      parent: _exposureModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    _focusModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );
    _focusModeControlRowAnimation = CurvedAnimation(
      parent: _focusModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );

    _availableCameras();
  }

  Future<void> _availableCameras() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();
      onNewCameraSelected(_cameras.first);
      if (mounted) setState(() {});
    } on CameraException catch (e) {
      _logError(e.code, e.description);
    }
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _flashModeControlRowAnimationController.dispose();
    _exposureModeControlRowAnimationController.dispose();
    // controller?.resumePreview();
    // if (controller?.value.isPreviewPaused == false) {
    //   controller?.dispose();
    //   // await controller?.pausePreview();
    // }
    controller?.dispose();
    // _forcePortrait();
    super.dispose();
  }

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (controller?.value.isPreviewPaused == false) {
        //   await controller?.pausePreview();
        // }
        return true;
      },
      child: Scaffold(
        backgroundColor: CC.transparent,
        body: _cameras.isEmpty
            ? Container()
            : Stack(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: imageFile == null
                                      ? _cameraPreviewWidget()
                                      : (inEditor
                                          ? Container()
                                          : _thumbnailWidget()),
                                ),
                              ),
                            ),
                          ),
                          imageFile == null
                              ? _modeControlRowWidget()
                              : (inEditor ? Container() : _thumbnailControl()),
                        ],
                      ),
                      inEditor
                          ? Container()
                          : Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: SafeArea(
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: CC.white,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Container();
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (TapDownDetails details) =>
                  onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    if (imageFile == null) return Container();
    // return RotatedBox(
    //     quarterTurns: _getQuarterTurns(),
    //     child: Image.file(File(imageFile!.path)));
    return Image.file(File(imageFile!.path));
  }

  /// Display a bar with buttons to change the flash and exposure modes
  Widget _modeControlRowWidget() {
    final CameraController? cameraController = controller;

    return Container(
      color: CC.black,
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.flash_on),
                  color: Colors.white,
                  onPressed:
                      controller != null ? onFlashModeButtonPressed : null,
                ),
                // IconButton(
                //   icon: Icon(controller?.value.isCaptureOrientationLocked ?? false
                //       ? Icons.screen_lock_rotation
                //       : Icons.screen_rotation),
                //   color: Colors.blue,
                //   onPressed: controller != null
                //       ? _onCaptureOrientationLockButtonPressed
                //       : null,
                // ),
                IconButton(
                    iconSize: 60,
                    icon: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3, color: CC.mainColor),
                        color: CC.white,
                      ),
                      child:
                          Icon(Icons.camera_alt, color: Colors.black, size: 30),
                    ),
                    onPressed: cameraController != null &&
                            cameraController.value.isInitialized &&
                            !cameraController.value.isRecordingVideo
                        ? onTakePictureButtonPressed
                        : null),
                // InkWell(
                //   onTap: cameraController != null &&
                //       cameraController.value.isInitialized &&
                //       !cameraController.value.isRecordingVideo
                //       ? onTakePictureButtonPressed
                //       : null,
                //   child: Container(
                //     margin: EdgeInsets.all(30),
                //     padding: EdgeInsets.all(15),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(35),
                //       border: Border.all(width: 1.r, color: CC.line),
                //       color: CC.white
                //     ),
                //     child: Icon(Icons.camera_alt,color: Colors.blueGrey,size: 30),
                //   ),
                // ),
                IconButton(
                  icon: const Icon(Icons.filter_center_focus),
                  color: Colors.white,
                  onPressed:
                      controller != null ? onFocusModeButtonPressed : null,
                )
              ],
            ),
          ),
          _flashModeControlRowWidget(),
          // _exposureModeControlRowWidget(),
          _focusModeControlRowWidget(),
        ],
      ),
    );
  }

  Widget _thumbnailControl() {
    return Container(
      color: CC.black,
      constraints: BoxConstraints(minHeight: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.close, size: 35, color: CC.white),
                  Text(
                    '重拍',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CC.white),
                  )
                ],
              ),
              onPressed: () {
                imageFile = null;
                onPausePreviewButtonPressed();
                if (mounted) setState(() {});
              }),
          IconButton(
              iconSize: 60,
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Icon(Icons.palette, size: 35, color: CC.mainColor),
                  Text(
                    '编辑',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CC.mainColor),
                  )
                ],
              ),
              onPressed: () async {
                if (imageFile != null) {
                  inEditor = true;
                  _imageEditor();
                  // if (mounted) setState(() {});
                  // String? xf = await KitCamera.image_editor(imageFile!.path);
                  // if (xf != null) {
                  //   imageFile = XFile(xf);
                  //   if (mounted) setState(() {});
                  // }
                }
              }),
          IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.done, size: 35, color: CC.white),
                  Text(
                    '使用',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CC.white),
                  )
                ],
              ),
              onPressed: () {
                Get.back(result: imageFile!.path);
              }),
        ],
      ),
    );
  }

  void _imageEditor() {
    // File f = File(imageFile!.path);
    // Get.to(()=>ImageEditorPage(path:imageFile!.path,callback: (x){
    //   if(x != null) imageFile  = XFile(x);
    //   Get.back();
    // },))?.then((value) {
    //   inEditor = false;
    //   if(value != null) imageFile  = XFile(value);
    //   if (mounted) setState(() {});
    // });
    ImageEditor.fire(imageFile!.path, onImageEditingComplete: (x) {
      inEditor = false;
      if (x != null) imageFile = XFile(x);
      if (mounted) setState(() {});
      if (widget.onImageEditingComplete != null)
        widget.onImageEditingComplete!(x);
    }, onCloseEditor: ( event) {
      inEditor = false;
      Get.back();
    });
  }

  Widget _flashModeControlRowWidget() {
    return SizeTransition(
      sizeFactor: _flashModeControlRowAnimation,
      child: ClipRect(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.flash_off),
              color: controller?.value.flashMode == FlashMode.off
                  ? Colors.orange
                  : Colors.blue,
              onPressed: controller != null
                  ? () => onSetFlashModeButtonPressed(FlashMode.off)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.flash_auto),
              color: controller?.value.flashMode == FlashMode.auto
                  ? Colors.orange
                  : Colors.blue,
              onPressed: controller != null
                  ? () => onSetFlashModeButtonPressed(FlashMode.auto)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.flash_on),
              color: controller?.value.flashMode == FlashMode.always
                  ? Colors.orange
                  : Colors.blue,
              onPressed: controller != null
                  ? () => onSetFlashModeButtonPressed(FlashMode.always)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.highlight),
              color: controller?.value.flashMode == FlashMode.torch
                  ? Colors.orange
                  : Colors.blue,
              onPressed: controller != null
                  ? () => onSetFlashModeButtonPressed(FlashMode.torch)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _exposureModeControlRowWidget() {
    final ButtonStyle styleAuto = TextButton.styleFrom(
      foregroundColor: controller?.value.exposureMode == ExposureMode.auto
          ? Colors.orange
          : Colors.blue,
    );
    final ButtonStyle styleLocked = TextButton.styleFrom(
      foregroundColor: controller?.value.exposureMode == ExposureMode.locked
          ? Colors.orange
          : Colors.blue,
    );

    return SizeTransition(
      sizeFactor: _exposureModeControlRowAnimation,
      child: ClipRect(
        child: Container(
          color: Colors.grey.shade50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('曝光模式', style: TextStyle(color: Colors.white)),
                  TextButton(
                    style: styleAuto,
                    onPressed: controller != null
                        ? () =>
                            onSetExposureModeButtonPressed(ExposureMode.auto)
                        : null,
                    onLongPress: () {
                      if (controller != null) {
                        controller!.setExposurePoint(null);
                        showInSnackBar('Resetting exposure point');
                      }
                    },
                    child: const Text('自动'),
                  ),
                  TextButton(
                    style: styleLocked,
                    onPressed: controller != null
                        ? () =>
                            onSetExposureModeButtonPressed(ExposureMode.locked)
                        : null,
                    child: const Text('锁定'),
                  ),
                  TextButton(
                    style: styleLocked,
                    onPressed: controller != null
                        ? () => controller!.setExposureOffset(0.0)
                        : null,
                    child: const Text('重置'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('曝光量'),
                  Text(_minAvailableExposureOffset.toString()),
                  Slider(
                    value: _currentExposureOffset,
                    min: _minAvailableExposureOffset,
                    max: _maxAvailableExposureOffset,
                    label: _currentExposureOffset.toString(),
                    onChanged: _minAvailableExposureOffset ==
                            _maxAvailableExposureOffset
                        ? null
                        : setExposureOffset,
                  ),
                  Text(_maxAvailableExposureOffset.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _focusModeControlRowWidget() {
    final ButtonStyle styleAuto = TextButton.styleFrom(
      foregroundColor: controller?.value.focusMode == FocusMode.auto
          ? Colors.orange
          : Colors.blue,
    );
    final ButtonStyle styleLocked = TextButton.styleFrom(
      foregroundColor: controller?.value.focusMode == FocusMode.locked
          ? Colors.orange
          : Colors.blue,
    );

    return SizeTransition(
      sizeFactor: _focusModeControlRowAnimation,
      child: ClipRect(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '聚焦模式',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    style: styleAuto,
                    onPressed: controller != null
                        ? () => onSetFocusModeButtonPressed(FocusMode.auto)
                        : null,
                    onLongPress: () {
                      if (controller != null) {
                        controller!.setFocusPoint(null);
                      }
                      showInSnackBar('重设焦点');
                    },
                    child: const Text('自动'),
                  ),
                  TextButton(
                    style: styleLocked,
                    onPressed: controller != null
                        ? () => onSetFocusModeButtonPressed(FocusMode.locked)
                        : null,
                    child: const Text('锁定'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );

    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      controller!.setDescription(cameraDescription);
    } else {
      _initializeCameraController(cameraDescription);
    }
    // logs('---_sensorOrientation-0-${cameraDescription.sensorOrientation}');
    // _sensorOrientation = cameraDescription.sensorOrientation;
    await controller!.unlockCaptureOrientation();
  }

  // int _getQuarterTurns2() {
  //   int quarterTurns;
  //   // controller.unlockCaptureOrientation()
  //   logs('---_sensorOrientation--${controller!.value.deviceOrientation}');
  //   logs('---previewPauseOrientation--${controller!.value.previewPauseOrientation}');
  //   // logs('---_sensorOrientation-1-${_sensorOrientation}');
  //
  //   switch (_sensorOrientation) {
  //     case 90:
  //       quarterTurns = 1;
  //       break;
  //     case 180:
  //       quarterTurns = 2;
  //       break;
  //     case 270:
  //       quarterTurns = 3;
  //       break;
  //     default:
  //       quarterTurns = 0;
  //   }
  //   quarterTurns = 0;
  //   return quarterTurns;
  // }

  int _getQuarterTurns() {
    int quarterTurns;
    logs('---_sensorOrientation--${controller!.value.deviceOrientation}');

    switch (controller!.value.deviceOrientation) {
      case DeviceOrientation.portraitUp:
        quarterTurns = 1;
        break;
      case DeviceOrientation.landscapeLeft:
        quarterTurns = 2;
        break;
      case DeviceOrientation.portraitDown:
        quarterTurns = 3;
        break;
      case DeviceOrientation.landscapeRight:
        quarterTurns = 0;
        break;
    }
    return quarterTurns;
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // await cameraController.unlockCaptureOrientation();
    controller = cameraController;
    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                cameraController.getMinExposureOffset().then(
                    (double value) => _minAvailableExposureOffset = value),
                cameraController
                    .getMaxExposureOffset()
                    .then((double value) => _maxAvailableExposureOffset = value)
              ]
            : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      imageFile = file;
      if (mounted) setState(() {});
    });
  }

  void onFlashModeButtonPressed() {
    if (_flashModeControlRowAnimationController.value == 1) {
      _flashModeControlRowAnimationController.reverse();
    } else {
      _flashModeControlRowAnimationController.forward();
      _exposureModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onExposureModeButtonPressed() {
    if (_exposureModeControlRowAnimationController.value == 1) {
      _exposureModeControlRowAnimationController.reverse();
    } else {
      _exposureModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onFocusModeButtonPressed() {
    if (_focusModeControlRowAnimationController.value == 1) {
      _focusModeControlRowAnimationController.reverse();
    } else {
      _focusModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _exposureModeControlRowAnimationController.reverse();
    }
  }

  Future<void> _onCaptureOrientationLockButtonPressed() async {
    try {
      if (controller != null) {
        final CameraController cameraController = controller!;
        if (cameraController.value.isCaptureOrientationLocked) {
          await cameraController.unlockCaptureOrientation();
          showInSnackBar('Capture orientation unlocked');
        } else {
          await cameraController.lockCaptureOrientation();
          showInSnackBar(
              'Capture orientation locked to ${cameraController.value.lockedCaptureOrientation.toString().split('.').last}');
        }
      }
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) {
        setState(() {});
      }
      String tx = '';
      switch (mode) {
        case FlashMode.off:
          tx = '关闭';
          break;
        case FlashMode.auto:
          tx = '自动开启';
          break;
        case FlashMode.always:
          tx = '总是开启';
          break;
        case FlashMode.torch:
          tx = '常亮';
          break;
      }
      showInSnackBar('闪光灯切换为 $tx');
    });
  }

  void onSetExposureModeButtonPressed(ExposureMode mode) {
    setExposureMode(mode).then((_) {
      if (mounted) {
        setState(() {});
      }
      String tx = '';
      switch (mode) {
        case ExposureMode.auto:
          tx = '自动';
          break;
        case ExposureMode.locked:
          tx = '锁定';
          break;
      }
      showInSnackBar('曝光模式切换为 $tx');
    });
  }

  void onSetFocusModeButtonPressed(FocusMode mode) {
    setFocusMode(mode).then((_) {
      if (mounted) {
        setState(() {});
      }
      String tx = '';
      switch (mode) {
        case FocusMode.auto:
          tx = '自动';
          break;
        case FocusMode.locked:
          tx = '锁定';
          break;
      }
      showInSnackBar('对焦模式切换为 $tx');
    });
  }

  Future<void> onPausePreviewButtonPressed() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isPreviewPaused) {
      await cameraController.resumePreview();
    } else {
      await cameraController.pausePreview();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureMode(ExposureMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setExposureMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureOffset(double offset) async {
    if (controller == null) {
      return;
    }

    setState(() {
      _currentExposureOffset = offset;
    });
    try {
      offset = await controller!.setExposureOffset(offset);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setFocusMode(FocusMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFocusMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  // Future<void> _d() async {
  //   if (controller?.value.isPreviewPaused == false) {
  //     await controller?.pausePreview();
  //   }
  // }

  Future<XFile?> takePicture() async {
    final CameraController? cam = controller;
    if (cam == null || !cam.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cam.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file;
      if (Platform.isAndroid) {
        // FocusMode fo = cam.value.focusMode;
        // ExposureMode ex = cam.value.exposureMode;
        // await cam.setFocusMode(FocusMode.locked);
        // await cam.setExposureMode(ExposureMode.locked);
        file = await cam.takePicture();
        // await cam.setFocusMode(fo);
        // await cam.setExposureMode(ex);
        //  以上代码替代下面这行，解决了拍照速度非常慢3-4s的问题。
        // final XFile file = await cam.takePicture();
      } else {
        file = await cam.takePicture();
      }
      onPausePreviewButtonPressed();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
