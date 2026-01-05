import 'package:app_kit/core/kt_export.dart';
import 'package:video_player/video_player.dart';

class CoPlayer extends StatefulWidget {
  final String url;
  final Function? call;

  const CoPlayer(this.url, {super.key, this.call});

  @override
  State<CoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<CoPlayer> {

  late VideoPlayerController _controller;
  bool isPlaying = false;
  var isBuffering = true.obs;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    )
      ..initialize().then((_) {
        // 确保视频初始化完成后再进行操作
        setState(() {});
        _controller.play();
        // _controller.setLooping(true);
        // _controller.addListener(_listener);

      });

    _controller.addListener(() {
      // 在这里处理播放和暂停状态的变化
      if (_controller.value.isPlaying) {
        isBuffering.value = false;
        print('视频正在播放');
      } else if (_controller.value.isBuffering) {
        isBuffering.value = true;
        print('视频已暂停');
      }
      if (widget.call != null) widget.call!(_controller.value.isPlaying);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() {}); // 移除监听器
    _controller.dispose();
  }

  void _listener() {
    if (_controller.value.isPlaying != isPlaying) {
      setState(() {
        isPlaying = _controller.value.isPlaying;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoAppBar('视频播放'),
      body: Center(
        child: _controller.value.isInitialized ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Obx(() {
          if (isBuffering.value) return CircularProgressIndicator(
            color: CC.mainColor,
          );
          return Container();
        }),
      ),
    );
  }
}
