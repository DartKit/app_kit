import 'dart:convert';
import 'package:app_kit/https/net.dart';
import 'api_response_entity.g.dart';

class KitResponse<T> {
  int? code;
  String? status;
  String? message;
  T? data;
  get isOk => code == Net().okCode;
  KitResponse();

  factory KitResponse.fromJson(Map<String, dynamic> json,{String dataKey = '',}) => $ApiResponseFromJson<T>(json,dataKey: dataKey);


  Map<String, dynamic> toJson() => $ApiResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
