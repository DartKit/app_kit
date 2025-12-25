import 'dart:async';
import 'dart:io';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/https/exception.dart';
import 'package:app_kit/models/api/api_response_entity.dart';
import 'package:app_kit/models/core/co_state.dart';
import 'package:dio/io.dart';
import 'package:hud/hud.dart';
// import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../core/kt_dao.dart';

Net net = Net();

class Net {
  late Dio dio;
  static Net? _instance;

  String _baseUrl = '';
  late int _successCode;
  late int _reLoginCode;
  Function(ApiException err)? _reLoginCall;

  bool _hasInit = false;
  Net._internal() {
    _instance = this;
    // init();
  }

  factory Net() => _instance ?? Net._internal();

  get okCode => _successCode;

  init({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 20),
    Duration sendTimeout = const Duration(seconds: 20),
    List<Interceptor> interceptors = const [],
    Function(ApiException err)? reLoginCall,
    int successCode = 0,
    int reLoginCode = 401,
  }) {
    _hasInit = true;
    _baseUrl = baseUrl;
    _successCode = successCode;
    _reLoginCode = reLoginCode;
    _reLoginCall = reLoginCall;
    _hasInit = true;
    dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout, sendTimeout: sendTimeout));
    dio.interceptors.addAll(interceptors);
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }

  Future<T?> get<T>(String url, {Map<String, dynamic>? query, String dataKey = '', Map? data, Map<String, dynamic>? headers, bool showErr = true, bool Function(ApiException)? onError, bool unTap = false, bool hud = true,bool isMoInAppKit = false}) {
    return request(url, query: query, dataKey: dataKey, headers: headers, onError: onError, unTap: unTap, showErr: showErr, data: data, hud: hud,isMoInAppKit:isMoInAppKit);
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? query, String dataKey = '', data, Map<String, dynamic>? headers, bool Function(ApiException)? onError, bool unTap = false, bool showErr = true, bool hud = true,bool isMoInAppKit = false}) {
    return request(url, method: "POST", query: query, data: data, dataKey: dataKey, headers: headers, onError: onError, unTap: unTap, showErr: showErr, hud: hud,isMoInAppKit:isMoInAppKit);
  }

  Future<T?> request<T>(
    String url, {
    String method = "GET",
    String dataKey = '',
    Map<String, dynamic>? query,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
    bool hud = true,
    bool unTap = false,
    bool showErr = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
        bool isMoInAppKit = false
  }) async {
    if (!_hasInit) init(baseUrl: kdao.baseUrl);
    if (url.startsWith('http')) {
      dio.options.baseUrl = '';
    } else {
      dio.options.baseUrl = _baseUrl;
    }

    if (dataKey.isEmpty) dataKey = url.urlQuery()['_rsp'] ?? '';
    // if (hud) kitHud(isAction: hud, dismissOnTap: !unTap);
    if (hud) Hud.show(barrierDismissible: !unTap);
    kdao.date0 = DateTime.now();

    try {
      Options options = Options()
        ..method = method
        ..headers = headers;

      if (!url.startsWith('/')) url = '/' + url;

      if (isDebug) {
        // if (query?.isNotEmpty == true) logs('---query--${json.encode(query)}');
        // if (data != null) logs('---data--${json.encode(data)}');
      }
      kdao.req_end = false;
      kdao.reqing = true;

      logs('--url--:${url}');
      Response response = await dio.request(url,queryParameters: query, data: data, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress);
      kdao.req_end = true;
      kdao.reqing = false;
      if (hud) Hud.hide();
      kitHideLoading();
      if (isNil(response.toString().isEmpty, '无数据返回')) return null;
      if (isMoInAppKit) {
        // logs('--response--:${response}');
        (T? tt,bool isGot) tt = Net.handleResponseBaseType<T>(response, showErr);
        if (tt.$2 == true) return tt.$1;
        // logs('--tt--:${tt}');
        return _handleResponse<T>(response, showErr, dataKey: dataKey, onError: onError);
      } else {
        return response as T;
      }
    } catch (e) {
      kdao.req_end = true;
      kdao.reqing = false;
      Hud.hide();
      logs('--catch-e-1-${e.toString()}');
      if (showErr) return getException<T>(e);
    }
    return null;
  }

  ///请求响应内容处理
  static (T?,bool isGot) handleResponseBaseType<T>(Response? response, bool showErr, ) {
    if (response?.statusCode == 200) {
      // logs('--response?.data.runtimeType--:${response?.data.runtimeType}');
      if (T == CoState) {
       return ((CoState()..state = true) as T,true);
      }
        // if (response?.data.runtimeType.toString().startsWith('_Map<') == true) {
      //   Map<String, dynamic> map = Map<String, dynamic>.from(response?.data);
      //   if (map.containsKey('data') && (T == CoState)) {
      //     var data = map['data'];
      //     if (data == null) return ((CoState()..state = true) as T,true);
      //     if ((data.runtimeType == bool)) return ((CoState()..state = true) as T,true);
      //   }
      // }

    } else {
      if (showErr == true && (response.toString() != 'null')) net.getException(response);
    }
    return (null,false);
  }
  ///请求响应内容处理
  static T? _handleResponse<T>(Response? response, bool showErr, {String dataKey = '', int? successCode, Function(ApiException err)? onError}) {
    KitResponse<T> apiResponse = KitResponse<T>.fromJson(response?.data.runtimeType == num ? null : response!.data, dataKey: dataKey);
    // logs('--apiResponse--:${apiResponse}--apiResponse.runtimeType--:${apiResponse.runtimeType}');
    return Net.handleBusinessResponse<T>(apiResponse, showErr, successCode: successCode, onError: onError);
  }


  ///业务内容处理
  static T? handleBusinessResponse<T>(KitResponse<T> response, bool showErr, {int? successCode, Function(ApiException err)? onError}) {
    if (response.code == (successCode ?? net.okCode)) {
      if (T == CoState) {
        CoState s = CoState();
        s.state = true;
        return s as T;
      }
      // logs('---response.data--${response.data}');
      // if (response.data == null) {
      //   if(hud)  _getException(response);
      //   return null;
      // }
      return response.data;
    } else {
      logs('---hud--$showErr--catch-e-3-$response');
      if (onError != null) onError(ApiException(response.code, response.message ?? '网络错误'));
      if (showErr) net.getException(response);
    }
    return null;
  }


  Future<T?> getException<T>(e) async {
    kitHideLoading();
    ApiException exception;
    int? code;
    String? msg;
    bool isApiResponse = false;

    if (e.runtimeType.toString().contains('KitResponse') == true) {
      code = (e as KitResponse).code;
      msg = (e).message;
      isApiResponse = true;
    } else {
      exception = ApiException.from(e);
      code = exception.code;
      msg = exception.message;
    }

    if (code == _reLoginCode) {
      kPopSnack(msg ?? '请重新登录', bgColor: CC.red, time: 5);
      if (_reLoginCall != null) _reLoginCall!(ApiException(code, msg));
      // if (isRelease) {
      //   // Global().clear();
      //   // Get.offAllNamed(AppPages.loginPage);
      // } else {
      //   // Get.toNamed(AppPages.loginPage, preventDuplicates: true);
      // }
    } else {
      logs('---code--$code');
      var exception = ApiException(code, msg);
      if ((code != null) && (code != _successCode)) kPopSnack(msg);

      if (isDebug) {
        logs('---exception--${exception.message}');
      }
      return null;
    }
    return null;
  }
}
