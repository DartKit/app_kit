import 'dart:math';
import 'package:app_kit/core/kt_export.dart';
import 'package:flutter/material.dart';
// import 'package:pigment/pigment.dart';

Color rgba(int r, int g, int b, double a) => Color.fromRGBO(r, g, b, a);
Color RGBA(int r, int g, int b, double a) => Color.fromRGBO(r, g, b, a);


class CC {
  // static const Color mainColor = Color(0xFF28B98C);
  static  Color get mainColor => kdao.mainColor?? Color(0xFF48BF70);
  static  Color keyColor = Color(0xFF48A963);

  static const Color keyGreen = Color(0xFF0BBD87);
  static const Color fiveColor = Color(0xFFCCCCCC);
  static const Color deepBlack = Color(0xFF213B32);
  static const Color lightBlack = Color(0xFFEEEEEE);
  static const Color deepGrey = Color(0xFF666666);
  static const Color lightGrey = Color(0xFF999999);
  static const Color line = Color(0xFF999999);
  static const Color line2 = Color(0x55999999);
  static const Color orange = Color(0xFFFF9900);
  static const Color bg = Color(0xFFF1F1F1);
  static const Color bg2 = Color(0xFFF7F7F7);

  static const Color FF666666 = Color(0xFF666666);
  static const Color subText1 = Color(0xFF807971);
  static const Color subText2 = Color(0xFF989DAF);
  static const Color subText3 = Color(0xFF5F5F5F);
  static const Color subText4 = Color(0xFF7C7F89);
  static const Color font = Color(0xFF333333);
  static const Color keyfont = Color(0xFF2A2E3E);
  static const Color keyRed = Color(0xFFFF685F);
  static const Color blue2 = Color(0xFF6C9BFF);

  static const Color FFCCCCCC = Color(0xFFCCCCCC);
  static const Color FFEEEEEE = Color(0xFFEEEEEE);

  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color blue = Colors.blue;
  static const Color yellow = Colors.yellow;
  static const Color green = Colors.green;
  static const Color deepPurpleAccent = Colors.deepPurpleAccent;

  /// 十六进制颜色， purple
  /// hex, 十六进制值，int类型支持如：0xffffff; 字符串类型支持如: '#FFD87D','#FFFFD87D','FFFFD87D'; Symbol符号类型：#FFFFD87D，#FFD87D
  /// alpha, 透明度 [0.0,1.0]
  static Color hex(dynamic hex, [double alpha = 1]) {
    int end = 0;
    if (hex.runtimeType == int) {
      end = hex;
    } else {
      String hexStr = '$hex';
      hexStr = hexStr.trim();
      if (hexStr.isEmpty) hexStr = '999999';
      List<String> ls = ['Symbol("', '")', '#', '0x', '0X', '.'];
      for (var o in ls) {
        hexStr = hexStr.replaceAll(o, '');
      }
      if (hexStr.length == 6 || hexStr.length == 7)
        hexStr = 'FF' + hexStr; //6位颜色。补位
      // end = int.parse(hexStr, radix: 16);
      return _getColor(hexStr);
    }
    return Color.fromRGBO((end & 0xFF0000) >> 16, (end & 0x00FF00) >> 8,
        (end & 0x0000FF) >> 0, alpha < 0 ? 0 : (alpha > 1 ? 1 : alpha));
  }

  /// 16进制字符串转Color
  /// 返回Color
  static Color hexToColor(String hex) {
    ArgumentError.checkNotNull(hex, "hex");

    // rgb argb
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (hex.length != 6 && hex.length != 8) {
      hex = '#999999';
    }
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    return Color(int.parse(hex, radix: 16));
  }

  static Color get random => Color.fromARGB(255, Random.secure().nextInt(255),
      Random.secure().nextInt(255), Random.secure().nextInt(255));

  static bool _hasCorrectHexPattern(String string) {
    string = string.replaceAll("#", "");
    String validChars = "0123456789AaBbCcDdEeFf";
    for (int i = 0; i < string.length; i++) {
      if (!validChars.contains(string[i])) {
        return false;
      }
    }
    return true;
  }

  static Color? _getRGBColorFromString(String string) {
    string = string.replaceAll(" ", ""); // pseudo-trimming
    if (string.startsWith("rgb(") && string.endsWith(")")) {
      // Correct
      string = string.replaceAll("rgb(", "");
      string = string.replaceAll(")", "");
      List<String> rgb = string.split(",");
      if (rgb.length == 3) {
        int r = int.parse(rgb[0]);
        int g = int.parse(rgb[1]);
        int b = int.parse(rgb[2]);
        return Color.fromARGB(255, r, g, b);
      }
      return null;
    }
    return null;
  }

  static Color _getColor(String color) {
    color = color.trim();

    Color? rgbColor = _getRGBColorFromString(color);
    if (rgbColor != null) {
      return rgbColor;
    }

    Color? finalColor;
    if (_hasCorrectHexPattern(color)) {
      color = color.replaceAll("#", "");
      int size = color.length;
      if (size == 6 || size == 3) {
        if (size == 3) {
          color =
              color[0] + color[0] + color[1] + color[1] + color[2] + color[2];
        }

        int value = int.parse(color, radix: 16);
        value = value + 0xFF000000;
        finalColor = Color(value);
      } else if (size == 8 || size == 4) {
        if (size == 4) {
          color = color[0] +
              color[0] +
              color[1] +
              color[1] +
              color[2] +
              color[2] +
              color[3] +
              color[3];
        }
        String alpha = color.substring(0, 2);
        // logs('--alpha--:${alpha}');
        color = alpha + color.substring(2, color.length);
        // logs('--color--:${color}');
        int value = int.parse(color, radix: 16);
        finalColor = Color(value);
      }
    }

    if (finalColor != null) {
      return finalColor;
    }

    // String? namedColor = cssColors[color];
    // if (namedColor != null && namedColor != "") {
    //   namedColor = namedColor.replaceAll("#", "");
    //   int value = int.parse(namedColor, radix: 16);
    //   value = value + 0xFF000000;
    //   return Color(value);
    // }

    throw 'color pattern [$color] not found! D:';
  }

  static Color hexStr(String color) {
    return _getColor(color);
  }

  // static Color fromCSSColor(CSSColor color) {
  //   String colorName =
  //       color.toString().substring(color.toString().indexOf('.') + 1);
  //   return _getColor(colorName);
  // }

  // static final List<Color> colorsT =  [
  //   Color(0xfff06783),
  //   Color(0xffafe3d6),
  //   Color(0xff42b3a1),
  //   Color(0xff0293ee),
  //   Color(0xfff8b250),
  //   Color(0xff845bef),
  //   Color(0xffefdb94),
  //   Color(0xfff0c8d3),
  //   Color(0xffecd9cb),
  //   Color(0xffcdd2b2),
  //   Color(0xffe5e5e5),
  //   Color(0xfff7ebb7),
  //   Color(0xffc3dae8),
  //   Color(0xffcad1e4),
  // ];
}


