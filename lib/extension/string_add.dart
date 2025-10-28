import 'dart:convert';
import 'package:app_kit/tools/hud.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';

/// 字符串扩展方法
extension AddString on String {
  int get toInt {
    if (this == '') return 0;
    return int.parse(this);
  }

  double get toDouble {
    if (this == '') return 0.0;
    return double.parse(this);
  }

  // 取整 小数点后面舍弃
  String get int0 {
    return formatNum(toDouble, 0);
  }

  // 保留1位小数
  String get double01 {
    if (isEmpty) return "0.0";
    return formatNum(toDouble, 1);
  }

  // 保留2位小数
  String get double02 {
    if (isEmpty) return "0.00";
    return formatNum(toDouble, 2);
  }

  // 保留2位小数
  String get double02Up {
    if (isEmpty) return "0.00";
    var d = (toDouble * 100).ceil();
    return (d / 100).toString();
  }

  // 保留几位小数
  String doubleNum(int position) {
    return formatNum(toDouble, position);
  }

  String ifNil(String str) {
    // if (isNotEmpty && (this != '0')) { 相等
    if (isNotEmpty) {
      return this;
    } else {
      return str;
    }
  }

  bool get yes {
    if ((this == '10') || (this == '1') || (this == 'true')) {
      return true;
    } else {
      return false;
    }
  }

  String ifNoAdd(String str) {
    if (contains(str)) {
      return this;
    } else {
      return this + str;
    }
  }

  String ifNotEqual(String x) {
    if (this == x) {
      return this;
    } else {
      return this + ' ' + x;
    }
  }

  String add(String x) {
    if (x.isNotEmpty) {
      if (isNotEmpty) {
        return this + ' ' + x;
      } else {
        return x;
      }
    } else {
      return this;
    }
  }

  String gang([bool isAdd = true]) {
    if (isNotEmpty) {
      if (startsWith('-')) {
        if (!isAdd) {
          return substring(1);
        }
      } else {
        if (isAdd) {
          return '-$this';
        }
      }
    }
    return this;
  }

  String get copyToClipboard {
    Clipboard.setData(ClipboardData(text: this));
    kitPopText('已复制：' + this);
    return this;
  }

  String get copyToClipboardNoTip {
    Clipboard.setData(ClipboardData(text: this));
    return this;
  }

  // 时间格式 MM-dd HH:mm
  String get time {
    return time_format('yyyy.MM.dd');
  }

  // 判断是否相等
  bool equal(String x) {
    bool isEqual = this == x;
    if (!isEqual) {
      String x1 = this;
      String x2 = x;
      if (x1.startsWith('/')) x1 = x1.substring(1);
      if (x2.startsWith('/')) x2 = x.substring(1);
      isEqual = x1 == x2;
    }
    return isEqual;
  }

  String addPrams(String x) {
    if (contains('?')) {
      return this + '&' + x;
    } else {
      return this + '?' + x;
    }
  }

  // 时间格式 传参
  String time_format(String format) {
    if (contains(":") && contains("-")) {
      String str = DateUtil.formatDateStr(this, isUtc: false, format: format);
      return str;
    }
    return this;
  }

  /// 手机号加星星省略
  String get phoneToStarNumber {
    String phoneStr = this;
    if (ObjectUtil.isEmpty(phoneStr)) {
      return phoneStr;
    } else {
      if (phoneStr.contains("-")) {
        phoneStr = (phoneStr.split('-'))[1];
      }
      if (phoneStr.length < 7) {
        return phoneStr;
      } else {
        phoneStr =
            "${phoneStr.substring(0, 3)}****${phoneStr.substring(7, phoneStr.length)}";
      }
    }
    return phoneStr;
  }

  /// 身份证加星星省略
  String get idCardToStarNumber {
    String str = this;
    if (ObjectUtil.isEmpty(str)) {
      return str;
    } else {
      if (str.length < 12) {
        return str;
      } else {
        str = str.substring(0, 6) + "******" + str.substring(12, str.length);
      }
    }
    return str;
  }

  /// 名字加星星省略
  String get nameToStarName {
    String name = this;
    if (ObjectUtil.isEmpty(name)) {
      return name;
    } else {
      if (name.length > 4) {
        return name;
      } else {
        name = name.substring(0, 1) + "*" + name.substring(2, name.length);
      }
    }
    return name;
  }

  String mapToUrl({required Map<String, dynamic> map}) {
    String urlNew = contains('?') ? (split('?').first) : this;
    if (map.isNotEmpty) {
      urlNew += '?';
      List ls = [];
      map.forEach((key, value) {
        ls.add('$key=$value');
      });
      urlNew += ls.join('&');
    }
    return urlNew;
  }

  /// 将url中的参数提取到map中
  Map<String, String>  urlQuery({bool removeXhx = false}) {
    Map<String, String> map = {};
    if (contains('?')) {
      String end = split('?').last;
      List sub = [];
      if (end.contains('&')) {
        sub = end.split('&');
      } else {
        sub.add(end);
      }
      for (String o in sub) {
        List values = o.split('=');
        if (removeXhx && values.first.toString().startsWith('_')){
          continue;
        }
        map[values.first] = values.last;
      }
    }
    // logs('---map11--$map');
    return map;
  }

  // Base64加
  String tob6() {
    if (isEmpty) return this;
    var content = utf8.encode(this);
    var digest = base64Encode(content);
    return digest;
  }

  String get e {
    if (isEmpty) return this;
    return Utf8Decoder().convert(base64Decode(this));
  }

/*
* num target
* position 位置
* isCrop 截取 = true 或 四舍五入 =false
* isFillIn 补全0
* */
  String formatNum(num target, int position,
      {bool isCrop = true, bool isFillIn = true}) {
    String t = target.toString();
    // 如果要保留的长度小于等于0 直接返回当前字符串
    if (position < 0) {
      return t;
    }
    if (t.contains(".")) {
      String t1 = t.split(".").last;
      if (t1.length >= position) {
        if (position == 0) {
          return t.split(".").first; // 取整
        }
        if (isCrop) {
          // 直接裁剪
          return t.substring(0, t.length - (t1.length - position));
        } else {
          // 四舍五入
          return target.toStringAsFixed(position);
        }
      } else {
        if (isFillIn) {
          // 不够位数的补相应个数的0
          String t2 = "";
          for (int i = 0; i < position - t1.length; i++) {
            t2 += "0";
          }
          return t + t2;
        } else {
          return t;
        }
      }
    } else {
      // 不含小数的部分补点和相应的0
      String t3 = position > 0 ? "." : "";
      for (int i = 0; i < position; i++) {
        t3 += "0";
      }
      return t + t3;
    }
  }
}
