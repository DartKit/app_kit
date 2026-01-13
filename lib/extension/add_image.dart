import 'dart:async' show Completer;
import 'package:flutter/material.dart' as material show Image, ImageConfiguration, ImageStreamListener;

/*
使用：
Image wxIcon = Image.asset("images/wx_icon.png");
var aspectRatio = await wxIcon.getAspectRatio();
print(aspectRatio);
* */
extension GetImageAspectRatio on material.Image {
  Future<double> getAspectRatio() {
    final completer = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
            (imageInfo, synchronousCall) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.height;
          imageInfo.image.dispose();
          completer.complete(aspectRatio);
        },
      ),
    );
    return completer.future;
  }
}