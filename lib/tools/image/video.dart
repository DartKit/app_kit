import 'package:app_kit/core/kt_export.dart';
import 'package:better_player_plus/better_player_plus.dart';

class VideoPlayer extends StatefulWidget {
  final String url;
  final Function(BetterPlayerEvent e)? onChange;
  final Function()? onClickJump;
  const VideoPlayer(this.url, {super.key,this.onChange,this.onClickJump});
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

//1、WidgetsBindingObserver {
class _VideoPlayerState extends State<VideoPlayer> with WidgetsBindingObserver {
  late BetterPlayerController _betterPlayerController;
  int time = 0;
  @override
  void initState() {
    super.initState();

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    //2.页面初始化的时候，添加一个状态的监听者
    WidgetsBinding.instance.addObserver(this);
    // var url = dao.url;
    // var url = 'http://vfx.mtime.cn/Video/2021/07/10/mp4/210710171112971120.mp4';  // 视频播放地址

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 500 * 1024 * 1024,
        maxCacheSize: 10000 * 1024 * 1024,
        maxCacheFileSize: 10000 * 1024 * 1024,

        ///Android only option to use cached video between app sessions
        key: "guanYangCacheKey",
      ),
    );
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    errorMessage ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            // placeholder: Center(child: Text('加载中...', style: TextStyle(color: C.white,fontSize: 14.r, fontWeight: AppFont.regular),)),
            aspectRatio: 1 / Get.pixelRatio,
            autoPlay: true,
            looping: false,
            allowedScreenSleep: false,
            fullScreenByDefault: false,
            fit: BoxFit.fill,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enablePip: false,
              enableFullscreen: false,
              enableOverflowMenu: false,
              enablePlaybackSpeed: false,
              enableQualities: false,
              enableRetry: true,
              enableSkips: false,
              progressBarPlayedColor: Colors.blue,
              // controlBarHeight: 160.r,
              backgroundColor: C.black,
              overflowModalColor: C.white,
              enablePlayPause: false,
              controlsHideTime: const Duration(milliseconds: 10),
              showControls: false,
              showControlsOnInitialize: false,
              controlBarColor: C.transparent,
            )),
        betterPlayerDataSource: betterPlayerDataSource);
    _betterPlayerController.preCache(betterPlayerDataSource);
    // _betterPlayerController.setVolume(0);
    _betterPlayerController.addEventsListener((event) {
      if (widget.onChange != null)  widget.onChange!(event);

      print("Better player event: ${event.betterPlayerEventType}");
      if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
        Future.delayed(Duration(milliseconds: 10000), () {
          _betterPlayerController.retryDataSource();
          _betterPlayerController.play();
        });
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.finished) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        // Get.offAll(MyHomePage(),transition: Transition.noTransition);
        // Get.offAll(()=>TabPage(),binding: HomeBinding());

      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.progress) {
        // logs('---event.parameters--${event.parameters}');
        // List l1 = event.parameters?["duration"].toString().split('.')?.first.split(':')??[];
        // List l2 = event.parameters?["progress"].toString().split('.')?.first.split(':')??[];
        // logs('---d7--${l2.last}');
        // time = l1.last.toString().toInt - l2.last.toString().toInt;
        // if (mounted) setState(() {});
      }
    });

    // Future.delayed(Duration(milliseconds: 1300000),(){ //异常后自动重试 300s后还没播放重启app
    //   if (_betterPlayerController.isPlaying() == false) {
    //     Get.to(MyHomePage());
    //   }
    // });

    // Future.delayed(Duration(milliseconds: 10000),(){
    //   _betterPlayerController.setVolume(0.5);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
    //3. 页面销毁时，移出监听者
    WidgetsBinding.instance.removeObserver(this);
  }

  //一些状态改变监听方法
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      //进入应用时候不会触发该状态 应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume
      case AppLifecycleState.resumed:
        logs("应用进入前台======");
        // _videoVc.se;

        break;
      //应用状态处于闲置状态，并且没有用户的输入事件，
      // 注意：这个状态切换到 前后台 会触发，所以流程应该是先冻结窗口，然后停止UI
      case AppLifecycleState.inactive:
        logs("应用处于闲置状态，这种状态的应用应该假设他们可能在任何时候暂停 切换到后台会触发======");
        break;
      //当前页面即将退出
      case AppLifecycleState.detached:
        logs("当前页面即将退出======");
        break;
      // 应用程序处于不可见状态
      case AppLifecycleState.paused:
        logs("应用处于不可见状态 后台======");
        // Restart.restartApp();
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayer();
  }

  Widget _videoPlayer() {
    return Container(
      color: C.black,
      child: Stack(
        children: [
          BetterPlayer(
            controller: _betterPlayerController,
          ),
         if (widget.onClickJump != null)  Positioned(
              right: 20.r,
              top: 30.r,
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                        overlays: SystemUiOverlay.values);
                    // Get.offAll(MyHomePage(),transition: Transition.noTransition);
                    // Get.offAll(()=>TabPage(),binding: HomeBinding());
                    if (widget.onClickJump != null) widget.onClickJump!();
                  },
                  child: Container(
                    height: 30.r,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r / 2),
                      border: Border.all(width: 1.r, color: C.white),
                    ),
                    child: Center(
                      child: Text('跳过', style: TextStyle(color: C.white)),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
