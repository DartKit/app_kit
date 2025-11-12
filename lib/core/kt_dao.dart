import 'dart:ui';

import 'package:get/get.dart';

KtDao get kdao => KtDao();

class KtDao {
  static KtDao? _instance;
  KtDao._internal() {
    _instance = this;
    _init();
  }

  factory KtDao() => _instance ?? KtDao._internal();
  String official = 'official';

  String token = '';
  late String channel = official;
  String app_name = '';
  String baseUrl = '';
  String appStoreUrl = '';
  List<String> hostUrls = [];
  String urlUpFileToOss = '';
  String urlUpFileToOwn = '';

  var noNet = false.obs;
  var inReq = false.obs;
  late DateTime date0;
  bool req_end = true;
  bool reqing = false;
  int _baseHostAtIndex = -1;

  bool get isLogin => token.isNotEmpty;

  set baseHostAtIndex (int index){
    _baseHostAtIndex = index;
    if (hostUrls.length >= index) baseUrl = hostUrls[index];
  }

  int get baseHostAtIndex {
    return _baseHostAtIndex >=0 ? _baseHostAtIndex: hostUrls.indexOf(baseUrl);
  }

  void _init() {}
}
