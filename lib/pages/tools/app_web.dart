import 'dart:io';
import 'package:app_kit/core/kt_dao.dart';
import 'package:app_kit/core/app_debug/app_debug.dart';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/widgets/kit_view.dart';
import 'package:app_kit/widgets/nav_sheet.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

// https://inappwebview.dev/docs/intro/

class AppWebPage extends StatefulWidget {
  bool isLoading = true; // 设置状态

  String url;
  String title;
  bool showBack;
  bool hasTopSafe;
  Color? topColor;
  bool showSysWeb; // 显示默认浏览器打开按钮
  Map<String, dynamic>? mapToUrl = {};
  @override
  AppWebPage({
    super.key,
    this.url = '',
    this.title = '',
    this.showBack = false,
    this.hasTopSafe = true,
    this.topColor,
    this.showSysWeb = false,
    this.mapToUrl,
  });

  @override
  State<StatefulWidget> createState() => _AppWebPageState();
}

class _AppWebPageState extends State<AppWebPage> {
  Color bgColor = C.white;
  var canGoBack = false.obs;
  var canGoForward = false.obs;
  var _appBarAlpha = 0.0.obs;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? _controller;
  InAppWebViewSettings settings = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  // InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
  //     crossPlatform: InAppWebViewOptions(
  //       useShouldOverrideUrlLoading: true,
  //       // preferredContentMode: UserPreferredContentMode.MOBILE,
  //       mediaPlaybackRequiresUserGesture: false,
  //     ),
  //     android: AndroidInAppWebViewOptions(
  //       useHybridComposition: true,
  //     ),
  //     ios: IOSInAppWebViewOptions(
  //       allowsInlineMediaPlayback: true,
  //     ));

  PullToRefreshController? pullReC;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    // WidgetsFlutterBinding.ensureInitialized();
    // if (Platform.isAndroid) {
    //    AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    // }

    if (widget.url.isNotEmpty && widget.mapToUrl != null) {
      widget.url = widget.url.mapToUrl(map: widget.mapToUrl!);
      logs('---widget.url--${widget.url}');
    }

    pullReC = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: C.mainColor,
      ),
      onRefresh: () async {
        logs('---pullReC--$pullReC');
        if (Platform.isAndroid) {
          // _controller?.reload();
          _controller?.loadUrl(urlRequest: URLRequest(url: await _controller?.getUrl()));
        } else if (Platform.isIOS) {
          _controller?.loadUrl(urlRequest: URLRequest(url: await _controller?.getUrl()));
        }
      },
    );

    // _setLocalStorage();
    // log(StackTrace.current, access_token);
    // 1626662813757
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoAppBar(widget.title.isEmpty
          ? null
          : CoAppBar(
              Text(
                widget.title,
                style: TextStyle(fontSize: 15.r),
              ),
              actions: [
                Obx(() => canGoBack.isFalse
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          _controller?.goBack();
                        },
                        child: Icon(Icons.arrow_circle_left_rounded))),
                Obx(() => canGoForward.isFalse
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          _controller?.goForward();
                        },
                        child: Icon(Icons.arrow_circle_right_rounded))),
                if (widget.showSysWeb)
                  InkWell(
                      onTap: () async {
                        if (await canLaunch(widget.url)) {
                          KitView.alert(
                              title: '在应用外打开',
                              content: '您要使用系统自带浏览器查看吗',
                              sure: () async {
                                await launch(
                                  widget.url.toString(),
                                );
                              });
                        }
                      },
                      child: Icon(Icons.open_in_browser)),
              ],
            )),
      backgroundColor: bgColor,
      body: SafeArea(
        top: widget.hasTopSafe,
        child: Stack(
          children: [
            _inAppWebView(),
            Obx(
              () => Opacity(
                opacity: _appBarAlpha.value,
                child: Container(
                  color: widget.topColor ?? Color(0xFFE6FAED),
                  height: kStaBarH(context),
                ),
              ),
            ),
            progress < 1.0
                ? SafeArea(
                    child: SizedBox(
                      height: 2,
                      child: LinearProgressIndicator(
                        value: progress,
                        color: C.mainColor,
                        backgroundColor: C.lightBlack,
                      ),
                    ),
                  )
                : Container(),
            if (widget.showBack) (widget.hasTopSafe ? _back() : Obx(() => Opacity(opacity: (1 - _appBarAlpha.value), child: _back()))),
          ],
        ),
      ),
    );
  }

  Widget _back() {
    return SafeArea(
        child: InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
          padding: EdgeInsets.all(10.r),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: C.white,
          )),
    ));
  }

  Widget _inAppWebView() {
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
      initialSettings: settings,
      pullToRefreshController: pullReC,
      onWebViewCreated: (controller) async {
        _controller = controller;
        await _setLocalStorage();
        // controller.reload();
        controller.addJavaScriptHandler(handlerName: 'handlerApp', callback: (args) {});
      },
      onLoadStart: (controller, url) async {
        // List<WebStorageItem> ls =  await _controller?.webStorage.localStorage.getItems()??[];
        // for (var o in ls) {
        //   logs('--localStorage-o.--${o.toMap()}');
        // }
        // _setLocalStorage();
        // widget.url = url.toString();
      },
      onPermissionRequest: (controller, request) async {
        return PermissionResponse(resources: request.resources, action: PermissionResponseAction.GRANT);
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var uri = navigationAction.request.url;
        // logs('---shouldOverrideUrlLoading:${uri}---uri?.scheme--${uri?.scheme}');
        if (uri?.scheme.startsWith('tel') == true) {
          if (await canLaunch(uri.toString())) {
            await launch(
              uri.toString(),
            );
            return NavigationActionPolicy.CANCEL;
          }
        }
        return NavigationActionPolicy.ALLOW;
      },
      onLoadStop: (controller, url) async {
        logs('---onLoadStop:$url');
        await _setLocalStorage();
        await _controller?.canGoBack().then((value) {
          canGoBack.value = value;
        });
        await _controller?.canGoForward().then((value) {
          canGoForward.value = value;
        });

        pullReC?.endRefreshing();
        // setState(() {
        //   widget.url = url.toString();
        //   // _title(url.toString());
        // });
      },
      onReceivedError: (controller, request, error) {
        pullReC?.endRefreshing();
      },
      onProgressChanged: (controller, progress) {
        if (progress == 100) {
          pullReC?.endRefreshing();
        }
        setState(() {
          this.progress = progress / 100;
        });
      },
      onUpdateVisitedHistory: (controller, url, androidIsReload) {
        setState(() {
          widget.url = url.toString();
        });
      },
      onConsoleMessage: (controller, consoleMessage) {
        logs(consoleMessage);
      },
      onScrollChanged: (InAppWebViewController controller, int x, int y) {
        // logs('---x--${x}---y--${y}');
        if (!widget.hasTopSafe) {
          double alpha = y / 400.0;
          // 处理小于 0 和 大于 1 极端情况
          // 如果只处于 0 ~ 1 之间 , 不做处理
          if (alpha < 0) {
            alpha = 0;
          } else if (alpha > 1) {
            alpha = 1;
          }
          _appBarAlpha.value = alpha;
        }
      },
      onTitleChanged: (controller, title) {
        // if (!(title.contains(kaa_cz))) {
        //   widget.title = title;
        //   if (mounted) setState(() {});
        // }
      },
    );
  }

  Future<void> _setLocalStorage() async {
    Map<String, dynamic> ma = {
      // "timer": 30.days.fromNow.millisecondsSinceEpoch
    };
    // String jsonStr = json.encode(ma);

    // Map<String, dynamic> device = {
    //   "token": dao.own.token,
    //   // "timer": 30.days.fromNow.millisecondsSinceEpoch
    // };
    // String deviceJson = json.encode(device);

    // print(jsonStr);
    // print(deviceJson);
    if (kdao.isLogin) {
      // WebStorageManager locSt = WebStorageManager.instance();
      await _controller?.evaluateJavascript(source: "window.localStorage.setItem('token','${kdao.token}')");
      await _controller?.evaluateJavascript(source: "window.localStorage.setItem('show_tool','${AppDebug.isShowing ? 1 : 0}')");

      // cookie = '''
      //     document.cookie = 'hj_access_token=${access_token}';
      //   ''';
    }
    // await _controller?.evaluateJavascript(source: cookie);
    // _controller?.evaluateJavascript(
    //     source:
    //         "window.localStorage.setItem('hj_device_options','$deviceJson')");

    // get the CookieManager instance
    // CookieManager cookieManager = CookieManager.instance();
// set the expiration date for the cookie in milliseconds
//     final expiresDate = DateTime.now().add(Duration(days: 365)).millisecondsSinceEpoch;
//     final url = Uri.parse(widget.url);
// set the cookie
//     await cookieManager.setCookie(
//       url: url,
//       name: "hj_access_token",
//       value: access_token,
//       expiresDate: expiresDate,
//       isSecure: false,
//     );

    // String str =  "document.getElementsByClassName('navbar').style.display='none'";
  }
}
