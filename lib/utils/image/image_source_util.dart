import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageSourceUtils {
  //方法1：获取网络图片 返回ui.Image
  static Future<ui.Image> getNetImage(String url,
      {int width = 160, int height = 160}) async {
    ByteData data = await NetworkAssetBundle(Uri.parse(url)).load(url);
    // final response = await Dio().get
    //  (url, options: Options(responseType: ResponseType.bytes));
    // final data = response.data;

    print("data length is ${data.buffer.asUint8List().length}");
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

//方法2.1：获取本地图片  返回ui.Image 需要传入BuildContext context
  static Future<ui.Image> getAssetImage2(String asset, BuildContext context,
      {width, height}) async {
    ByteData data = await DefaultAssetBundle.of(context).load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

//方法2.2：获取本地图片 返回ui.Image 不需要传入BuildContext context
  static Future<ui.Image> getAssetImage(String asset, {width, height}) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
