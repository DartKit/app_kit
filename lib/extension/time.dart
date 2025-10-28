import 'package:app_kit/extension/pduration_add.dart';
import 'package:time/time.dart';

/// 字符串扩展方法
extension Time on String {
  String get today {
    String td = DateTime.now().toString().split(' ').first;
    return td;
  }

  String reduceMinute(int minute) {
    if (isEmpty) return this;
    if (this == 'null') return '';
    String today = DateTime.now().toString().split(' ').first + ' ';
    DateTime st0 = DateTime.parse(today + this);
    DateTime stPop0 = st0 - minute.minutes;
    String tPop0 = stPop0.hms;
    return tPop0;
  }

  String addMinute(int minute) {
    if (isEmpty) return this;
    if (this == 'null') return '';
    String today = DateTime.now().toString().split(' ').first + ' ';
    DateTime st0 = DateTime.parse(today + this);
    DateTime stPop0 = st0 + minute.minutes;
    String tPop0 = stPop0.hms;
    return tPop0;
  }
}
