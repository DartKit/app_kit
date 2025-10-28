import 'dart:async';
import 'package:app_kit/core/kt_export.dart';
import 'package:better_player_plus/better_player_plus.dart';
import '../widgets/info_tip.dart';

class LivePlayer extends StatefulWidget {
  final String preUrl;
  final String title;
  final bool reUrl;
  const LivePlayer(this.preUrl,
      {super.key, this.title = '', this.reUrl = false});
  @override
  State<LivePlayer> createState() => _LivePlayerState();
}

//1、WidgetsBindingObserver {
class _LivePlayerState extends State<LivePlayer> with WidgetsBindingObserver {
  late BetterPlayerController _betterPlayerController;
  bool _isPlaying = true;
  Timer? _timer;
  String _url = '';

  @override
  void initState() {
    //2.页面初始化的时候，添加一个状态的监听者
    // WidgetsBinding.instance.addObserver(this);
    if (widget.reUrl) _req_live(init: true);
    _initPlayer();
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_url.isEmpty) return;
      if (timer.tick % 601 == 0) {
        _req_live();
      }
      if (timer.tick % 15 == 0) {
        bool? f = _betterPlayerController.isPlaying();
        if (_isPlaying != f) {
          logs('-fff--f--$f');
          kPopSnack('播放异常，请稍后重试!');
          _req_restart();
        }
      }
    });
  }

  void _initPlayer() async {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);

    // var url = dao.url;
    // var url = 'http://vfx.mtime.cn/Video/2021/07/10/mp4/210710171112971120.mp4';  // 视频播放地址
    // url = 'http://192.168.0.142:8591/live?port=1935&app=live&stream=17153031635485294';

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, _url,
        liveStream: true);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            // placeholder: Center(child: Text('加载中...', style: TextStyle(color: C.white,fontSize: 14.r, fontWeight: AppFont.regular),)),
            // aspectRatio: 1/Get.pixelRatio,
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
            // aspectRatio: Get.pixelRatio,
            autoPlay: false,
            looping: false,
            allowedScreenSleep: false,
            fullScreenByDefault: false,
            fit: BoxFit.fill,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enablePip: false,
              enableFullscreen: true,
              enableOverflowMenu: false,
              enablePlaybackSpeed: false,
              enableQualities: false,
              enableRetry: true,
              enableSkips: false,
              enableProgressBar: false,
              backgroundColor: C.black,
              enablePlayPause: false,
              showControls: true,
              showControlsOnInitialize: false,
              controlBarHeight: 60.r,
              // fullscreenEnableIcon: Icons.replay,
              controlBarColor: C.transparent,
            )),
        betterPlayerDataSource: betterPlayerDataSource);
    // _betterPlayerController.preCache(betterPlayerDataSource);
    // _betterPlayerController.setVolume(0);

    _betterPlayerController.addEventsListener((event) {
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
        // // Get.offAll(MyHomePage(),transition: Transition.noTransition);
        // // Get.offAll(()=>TabPage(),binding: HomeBinding());
        // Get.offAllNamed(AppPages.launchHome);
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
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
    _timer?.cancel();
    // //3. 页面销毁时，移出监听者
    // WidgetsBinding.instance.removeObserver(this);
  }

  void _req_live({init = false}) async {
    // http://192.168.0.142:8898/http_live?rtsp=rtps://admin:xxxxxxxx
    var req_url = widget.preUrl;
    Dio dio = Dio();
    Response x = await dio.request(req_url);
    if (x.data != null) {
      Map<String, dynamic> map = x.data;
      var url = map['data']['http_url'].toString();
      logs('---x--$url');
      _url = url;
      // _url = url.replaceFirst('http://', 'file://');
      // _url = 'http://vjs.zencdn.net/v/oceans.mp4';
      // _url = 'rtsp://admin:sdhjkj123@192.168.0.70:554/h264/ch1/main/av_stream';
      logs('---_url--$_url');
      _betterPlayerController.setupDataSource(BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, _url,
        liveStream: true,
        // headers:
      ));
      _betterPlayerController.play();
    }
  }

  void _req_restart() async {
    // http://192.168.0.142:8898/http_live?action=restart
    var req_url = widget.preUrl.split('?').first;
    req_url += '?action=restart';
    Dio dio = Dio();
    Response x = await dio.request(req_url);
    if (x.data != null) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _LivePlayer();
  }

  Widget _LivePlayer() {
    return Scaffold(
      appBar: CoAppBar(
        widget.title,
        backgroundColor: widget.title.isEmpty ? C.black : C.white,
        leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: widget.title.isEmpty ? C.white : C.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoTip(
                '保持设备和监控设备在同一局域网中方可观看！',
                fontSize: 14.r,
              ),
              Container(
                color: C.black,
                child: BetterPlayer(
                  controller: _betterPlayerController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
