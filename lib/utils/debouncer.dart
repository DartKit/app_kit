import 'dart:async';
import 'dart:ui';

export 'package:app_kit/core/app_log.dart';

after2s(Function() action) async {
  Debouncer().run(call: action,time: 2000);
}
after1s(Function() action) async {
  Debouncer().run(call: action,time: 1000);
}

after0d5s(Function() action) async {
  Debouncer().run(call: action,time: 500);
}
DateTime? _t0 = DateTime.now();


class Debouncer {
  static Debouncer? _instance;
  Debouncer._internal() {
    _instance = this;
    _t0 = DateTime.now();
  }
  factory Debouncer() => _instance ?? Debouncer._internal();   ///判空符??
  // 如下都是单例以外的业务

  DateTime? _t1 = DateTime.now();

  // 运行防抖动作
  void run({required VoidCallback call,int time = 1000}) {
    _t1 = DateTime.now();
    // logs('---_t1!.difference(_t0!).inMilliseconds--${_t1!.difference(_t0!).inMilliseconds}');
    if (_t1!.difference(_t0!).inMilliseconds > time) {
      _t0 = DateTime.now();
      call();
    }else {
      Future.delayed(Duration(milliseconds: time),(){
        _t0 = DateTime.now();
      });
    }

  }

}
