import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';
import 'dart:developer';

///日志模型
enum LogsMode {
  debug, // 💙 DEBUG
  warning, // 💛 WARNING
  info, // 💚 INFO
  error, // ❤️ ERROR
}

///日志
void logs(dynamic msg, {LogsMode mode = LogsMode.debug}) {
  if (kDebugMode == false) return; // release模式不打印

  var chain = Chain.current(); // Chain.forTrace(StackTrace.current);
  // 将 core 和 flutter 包的堆栈合起来（即相关数据只剩其中一条）
  chain =
      chain.foldFrames((frame) => frame.isCore || frame.package == "flutter");
  // 取出所有信息帧
  final frames = chain.toTrace().frames;
  // 找到当前函数的信息帧
  final idx = frames.indexWhere((element) => element.member == "logs");
  if (idx == -1 || idx + 1 >= frames.length) {
    return;
  }
  // 调用当前函数的函数信息帧
  final frame = frames[idx + 1];

  var modeStr = "";
  switch (mode) {
    case LogsMode.debug:
      modeStr = "💙💙ddd debug";
      break;
    case LogsMode.warning:
      modeStr = "💛💛www warning";
      break;
    case LogsMode.info:
      modeStr = "💚💚iii info";
      break;
    case LogsMode.error:
      modeStr = "❤️❤️️eee error";
      break;
  }

  // logs('---frame.uri.toString()---:${frame.uri.toString()}');
  if (kDebugMode) {
    // logs(stringBuffer.toString());
    // StringBuffer buf =  StringBuffer();
    String str =
        "🔻🔻${DateTime.now()} $modeStr ${frame.uri.toString()}:${frame.line} \n${msg.toString()}\n🔺🔺🔺🔺🔺🔺🔺🔺🔺";
    // buf.write(str);
    // debugPrint("🔻🔻${DateTime.now()} $modeStr ${frame.uri.toString()}:${frame.line} \n $msg" '\n🔺🔺🔺🔺🔺🔺🔺🔺🔺');
    // debugPrint(buf.toString());
    // log(buf.toString());
    log(str);
    // Future.microtask(() => log(str));
  }
}

/*
/// log输出
class klog {
  static const String _tagDef = "🔻🔻🔻️app_log🔻🔻🔻";
  static String _tag = _tagDef;

  // static bool isRelease =  bool.fromEnvironment("dart.vm.product");


  static void init({String tag = _tagDef}) {
    _tag = _tagDef;
  }

  static void d(Object object, {String? tag}) {
    _pringLog(tag, ' ddd ', object);
  }

  static void v(Object object, {String? tag}) {
    _pringLog(tag, ' vvv ', object);
  }

  static void e(Object object, {String? tag}) {
    _pringLog(tag, ' eee ', object);
  }

  static void _pringLog(String? tag, String sTag, Object object) {
    StringBuffer stringBuffer =  StringBuffer();
    stringBuffer.write(null == tag || tag.isEmpty ? _tag : tag);
    stringBuffer.write(sTag+'\n');
    stringBuffer.write(object);
    if (kDebugMode) {
      // logs(stringBuffer.toString());
      debugPrint(stringBuffer.toString()+'\n🔺🔺🔺🔺🔺🔺🔺🔺🔺');
    }
  }
}
*/
