import 'package:app_kit/core/app_define.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiException implements Exception {
  static const unknownException = "未知错误";
  final String? message;
  final int? code;
  String? stackInfo;

  ApiException([this.code, this.message]);

  factory ApiException.fromDioError(DioException error) {
    var errorText = '网络异常，请检查网络后重试!';
    switch (error.type) {
      case DioExceptionType.cancel:
        kPopSnack('请求取消', bgColor: Colors.red);
        break;
      case DioExceptionType.connectionTimeout:
        kPopSnack('连接超时', bgColor: Colors.red);
        break;
      case DioExceptionType.sendTimeout:
        kPopSnack('请求超时', bgColor: Colors.red);
        break;
      case DioExceptionType.receiveTimeout:
        kPopSnack('响应超时', bgColor: Colors.red);
        break;
      case DioExceptionType.badResponse:
        kPopSnack('响应失败', bgColor: Colors.red);
        break;
      case DioExceptionType.connectionError:
        kPopSnack(errorText, bgColor: Colors.red);
        break;
      case DioExceptionType.unknown:
        return BadRequestException(-1, errorText);
      default:
        return ApiException(-1, error.message);
    }
    return BadRequestException();
  }

  factory ApiException.from(dynamic exception) {
    if (exception is DioException) {
      return ApiException.fromDioError(exception);
    } else if (exception is ApiException) {
      return exception;
    } else {
      var apiException = ApiException(-1, unknownException);
      apiException.stackInfo = exception?.toString();
      return apiException;
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([super.code, super.message]);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int super.code = -1, String super.message = '']);
}
