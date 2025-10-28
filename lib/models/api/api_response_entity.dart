import 'dart:convert';
import 'package:app_kit/https/net.dart';
import 'api_response_entity.g.dart';

class ApiResponse<T> {
  int? code;
  String? status;
  String? message;
  T? data;
  get isOk => code == Net().okCode;
  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json,{String dataKey = '',}) => $ApiResponseFromJson<T>(json,dataKey: dataKey);


  Map<String, dynamic> toJson() => $ApiResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
