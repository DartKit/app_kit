import 'package:flutter/material.dart';

/// 创建日期: 2020/8/14
/// 作者: lijianbin
/// 描述:

///路由监听,使用时在MaterialAPP中的navigatorObservers直接赋值
///
/// void main() {
///  runApp(MaterialApp(
///    navigatorObservers: [lifeObserver],
///    home: FirstWidget(),
///  ));
///}

final RouteObserver<Route> lifeObserver = RouteObserver();

///具有Widget生命周期监听的State类,使用时和State方式一样,
///当widget可见时,回调onResume(),
///不可见时,回调onPaused(),
///
///当Apush打开B,A会调用onPaused(),B调用onResume();
///当Bpop返回A,A会调用onResume(),B调用onPaused();
///当锁屏或退入后台时,会调用onPaused();
///当从后台转入前台或从锁屏解锁后,会调用onResume();
///
/// 使用时,直接将State替换为LifeState即可
/// 不建议在回调用做大量的耗时操作,可以做一些定时任务的启停标记
///
abstract class LifeState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver, RouteAware {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    lifeObserver.subscribe(this, ModalRoute.of(context) as Route);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    lifeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    } else if (state == AppLifecycleState.paused) {
      onPaused();
    }
  }

  @override
  void didPop() {
    onPaused();
  }

  @override
  void didPopNext() {
    onResume();
  }

  @override
  void didPush() {
    onResume();
  }

  @override
  void didPushNext() {
    onPaused();
  }

  void onResume();

  void onPaused();
}
