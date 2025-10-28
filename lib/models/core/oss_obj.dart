import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/oss_obj.g.dart';
import 'dart:convert';
export 'package:app_kit/generated/json/oss_obj.g.dart';

@JsonSerializable()
class OssObj {
  late String uid = '';
  late String url = '';
  late int size = 0;
  late String name = '';
  late String type = '';
  late String thumbUrl = '';

  OssObj();

  factory OssObj.fromJson(Map<String, dynamic> json) => $OssObjFromJson(json);

  Map<String, dynamic> toJson() => $OssObjToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
