import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/oss_token.g.dart';
import 'dart:convert';

@JsonSerializable()
class OssToken {
  late String id = '';
  late String host = '';
  late String policy = '';
  late String signature = '';
  late int expire = 0;
  late String callback = '';
  late String dir = '';
  late String path = '';
  late String url = '';

  OssToken();

  factory OssToken.fromJson(Map<String, dynamic> json) =>
      $OssTokenFromJson(json);

  Map<String, dynamic> toJson() => $OssTokenToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
