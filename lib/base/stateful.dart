import 'dart:async';
import 'package:app_kit/core/kt_export.dart';
import '../models/core/sd_search.dart' show SdSearch;
/*
mixin BaseState {
  /// 是否刷新
  bool reload = false;

  /// 当前数据
  Map<String,dynamic> data = {};
  /// 分页
  int current = 1;
  /// 分页大小
  int pageSize = 20;
  /// 分类id
  Object sortId = '';
  /// 分类下标
  int sortIndex = 0;
  /// nav sege
  int segeIndex = 0;
  /// 分类数组
  List sortArr = [];
  /// 列表数据
  List ls = [];
  // List<SdSearch> get search {
  //   return _search;
  // }
  // set search (List<SdSearch> x) {
  //
  //   _search = x;
  // }
  bool noData = false;

  Future<void> get checkNoData async {
    if(ls.isEmpty) {
      noData = true;
    }else {
      noData = false;
    }
  }

  /// 搜索入参
  Map<String,dynamic> param = {};
  /// 搜索项数据
  List<SdSearch> search = [];


}
*/

/// State 基类

class BaState<T extends StatefulWidget> extends State<T> {
  /// 是否刷新
  bool reload = false;

  /// 当前数据
  Map<String, dynamic> data = {};

  /// 分页
  int current = 1;

  /// 分页大小
  int pageSize = 20;

  /// 分类id
  Object sortId = '';

  /// 分类下标
  int sortIndex = 0;

  /// nav sege
  int segeIndex = 0;

  /// 分类数组
  List sortArr = [];

  /// 列表数据
  List ls = [];
  bool noData = false;

  Future<bool> get checkNoData async {
    kdao.inReq.value = false;
    return noData = ls.isEmpty;
  }

  /// 搜索入参
  Map<String, dynamic> param = {};

  /// 搜索项数据
  List<SdSearch> search = [];

  var _netSub = <StreamSubscription>[];

  @override
  void initState() {
    super.initState();
    // Get.lazyPut(() => NetCheck());
    if (kdao.noNet.isTrue) noData = true;
    _netSub = [
      kdao.noNet.listen((p0) {
        noData = p0;
        if (mounted) setState(() {});
        if (noData == false) onReq();
      })
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _netSub.forEach((e) {
      e.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  onReq() {}
}
