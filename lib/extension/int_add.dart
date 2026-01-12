import 'dart:io';

extension AddInt on int {
  bool get yes {
    if ((this == 10) || (this == 1)) {
      return true;
    } else {
      return false;
    }
  }

  bool get no {
    if ((this != 1) && (this != 10)) {
      return true;
    } else {
      return false;
    }
  }

  bool get is0 {
    if (this == 0) {
      return true;
    } else {
      return false;
    }
  }

  String get weekDay {
    if ((this >= 1) && (this <= 7)) return ['一', '二', '三', '四', '五', '六', '日'][this - 1];
    return '';
  }

  String get toTime {
    if (this <= 0) {
      return '0:00';
    } else {
      Duration d = Duration(seconds: this);
      List<String> parts = d.toString().split(':');
      int h = int.parse(parts[0]);
      var m = parts[1];
      var s = parts[2].toString().split('.').first;

      if (h > 0) {
        return '$h:$m:$s';
      } else {
        return '$m:$s';
      }
    }
  }

  String get to2Bit {
    if (this <= 0) {
      return '00';
    } else {
      String str = toString();
      if (str == '') return '00';
      if (str == 'null') return '00';
      if (str.length == 1) {
        return '0$this';
      } else {
        return str;
      }
    }
  }

  int ifNil(int str) {
    if (this > 0) {
      return this;
    } else {
      return str;
    }
  }

  int if0(int num) {
    if (this > 0) {
      return this;
    } else {
      return num;
    }
  }

  int get mapLine {
    return this ~/ (Platform.isIOS ? 3 : 1);
  }
}
