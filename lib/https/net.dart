import 'dart:io';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/https/exception.dart';
import 'package:app_kit/models/api/api_response_entity.dart';
import 'package:app_kit/models/core/co_state.dart';
import 'package:dio/io.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
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

  // bool _hasInit = false;
  Net._internal() {
    _instance = this;
    // init();
  }

  factory Net() => _instance ?? Net._internal();

  get okCode => _successCode;

  init({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor> interceptors = const [],
    Function(ApiException err)? reLoginCall,
    int successCode = 200,
    int reLoginCode = 401,
  }) {
    _baseUrl = baseUrl;
    _successCode = successCode;
    _reLoginCode = reLoginCode;
    _reLoginCall = reLoginCall;

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

  Future<T?> request<T>(
    String url, {
    String method = "GET",
    String dataKey = '',
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
    bool hud = true,
    bool unTap = false,
    bool showErr = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    if (url.startsWith('http')) {
      dio.options.baseUrl = '';
    } else {
      dio.options.baseUrl = _baseUrl;
    }

    if (dataKey.isEmpty) dataKey = url.urlQuery()['_rsp']??'';
    if (hud) kitHud(isAction: hud, dismissOnTap: !unTap);
    kdao.date0 = DateTime.now();

    try {
      Options options = Options()
        ..method = method
        ..headers = headers;

      if (!url.startsWith('/')) url = '/' + url;

      if (isDebug) {
        if (queryParameters?.isNotEmpty == true) logs('---queryParameters--${json.encode(queryParameters)}');
        if (data != null) logs('---data--${json.encode(data)}');
      }
      kdao.req_end = false;
      kdao.reqing = true;

      Response response = await dio.request(url, queryParameters: queryParameters, data: data, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress);
      kdao.req_end = true;
      kdao.reqing = false;
      kitHideLoading();
      if (isNil(response.toString().isEmpty, '无数据返回')) return null;
      return _handleResponse<T>(response, showErr, dataKey: dataKey, onError: onError);
    } catch (e) {
      kdao.req_end = true;
      kdao.reqing = false;

      logs('--catch-e-1-${e.toString()}');
      if (showErr) return _getException<T>(e);
    }
    return null;
  }

  Future<T?> get<T>(String url, {Map<String, dynamic>? queryParameters, String dataKey = '', Map? data, Map<String, dynamic>? headers, bool showErr = true, bool Function(ApiException)? onError, bool unTap = false, bool hud = true}) {
    return request(url, queryParameters: queryParameters, dataKey: dataKey, headers: headers, onError: onError, unTap: unTap, showErr: showErr, data: data, hud: hud);
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? queryParameters, String dataKey = '', data, Map<String, dynamic>? headers, bool Function(ApiException)? onError, bool unTap = false, bool showErr = true, bool hud = true}) {
    return request(url, method: "POST", queryParameters: queryParameters, data: data, dataKey: dataKey, headers: headers, onError: onError, unTap: unTap, showErr: showErr, hud: hud);
  }

  ///请求响应内容处理
  T? _handleResponse<T>(Response? response, bool showErr, {String dataKey = '', int? successCode, Function(ApiException err)? onError}) {
    if (response?.statusCode == 200) {
      // logs('--response?.data--:${response?.data}');
      // logs('--response?.data.runtimeType--:${response?.data.runtimeType}');
      if (response?.data.runtimeType.toString().startsWith('_Map<') == true) {
        Map<String, dynamic> map = Map<String, dynamic>.from(response?.data);
        if (map.containsKey('data') && (T == CoState)) {
          var data = map['data'];
          if (data == null) return (CoState()..state = true) as T;
          if ((data.runtimeType == bool)) return (CoState()..state = true) as T;
        }
      }

      ApiResponse<T> apiResponse = ApiResponse<T>.fromJson(response?.data.runtimeType == num ? null : response!.data, dataKey: dataKey);
      return _handleBusinessResponse<T>(apiResponse, showErr, successCode: successCode, onError: onError);
    } else {
      logs('--catch-e-2-$response');
      if (showErr == true && (response.toString() != 'null')) _getException(response);
    }
    return null;
  }

  ///业务内容处理
  T? _handleBusinessResponse<T>(ApiResponse<T> response, bool showErr, {int? successCode, Function(ApiException err)? onError}) {
    if (response.code == (successCode ?? _successCode)) {
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
      if (showErr) _getException(response);
    }
    return null;
  }

  Future<T?> _getException<T>(e) async {
    kitHideLoading();
    ApiException exception;
    int? code;
    String? msg;
    bool isApiResponse = false;

    if (e.runtimeType.toString().contains('ApiResponse') == true) {
      code = (e as ApiResponse).code;
      msg = (e).message;
      isApiResponse = true;
    } else {
      exception = ApiException.from(e);
      code = exception.code;
      msg = exception.message;
    }

    if (code == _reLoginCode) {
      kPopSnack(msg ?? '请重新登录', bgColor: C.red, time: 5);
      if (_reLoginCall != null)  _reLoginCall!(ApiException(code, msg));
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
