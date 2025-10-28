import 'package:app_kit/core/kt_export.dart';
import 'package:easy_refresh/easy_refresh.dart';

class HeadFoot {
  static init() {
    EasyRefresh.defaultHeaderBuilder = () => header;
    EasyRefresh.defaultFooterBuilder = () => footer;
  }

  static ClassicHeader get header {
    return const ClassicHeader(
      processingText: '正在加载...',
      readyText: '正在加载...',
      processedText: '加载成功',
      showMessage: false,
      armedText: '松手加载...',
      dragText: '下拉刷新...',
      succeededIcon: Icon(Icons.done),
    );
  }

  static ClassicFooter get footer {
    return const ClassicFooter(
      noMoreText: '～ 没有更多数据了 ～      ',
      showMessage: false,
      iconDimension: 24,
      infiniteOffset: null,
      spacing: 5,
      noMoreIcon: SizedBox(),
      readyText: '开始加载...',
      dragText: '上拉加载更多...',
      processingText: '正在加载...',
      processedText: '正在加载...',
      armedText: '松手开始加载...',
      succeededIcon: SizedBox(),
      // succeededIcon: Icon(Icons.done),
    );
  }
}
