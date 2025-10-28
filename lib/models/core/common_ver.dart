import 'dart:convert';
import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/common_ver.g.dart';
import 'package:app_kit/models/core/oss_obj.dart';

@JsonSerializable()
class CommonVer {
  late CommonVerVersion info = CommonVerVersion();
  CommonVer();

  factory CommonVer.fromJson(Map<String, dynamic> json) =>
      $CommonVerFromJson(json);

  Map<String, dynamic> toJson() => $CommonVerToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CommonVerVersion {
  late String name = '';
  late String version = '';
  late List<OssObj> url = [];
  late String created_at = '';
  late List<String> remark = [];
  late List<int> project_list = [];
  late List<ChannelVer> channels = [];

  late String ios_version = '';
  late int code = 0;
  late int ios_code = 0;
  late int force = 0;
  late int ios_force = 0;
  late bool force_format = false;
  late bool ios_force_format = false;

  CommonVerVersion();

  factory CommonVerVersion.fromJson(Map<String, dynamic> json) =>
      $CommonVerVersionFromJson(json);

  Map<String, dynamic> toJson() => $CommonVerVersionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ChannelVer {
  late String url = '';
  late String name = '';
  late String channel = '';

  ChannelVer();

  factory ChannelVer.fromJson(Map<String, dynamic> json) =>
      $ChannelVerFromJson(json);

  Map<String, dynamic> toJson() => $ChannelVerToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PatrolTotalMo {
  late PatrolTotalSon info = PatrolTotalSon();
  PatrolTotalMo();

  factory PatrolTotalMo.fromJson(Map<String, dynamic> json) =>
      $PatrolTotalMoFromJson(json);

  Map<String, dynamic> toJson() => $PatrolTotalMoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PatrolTotalSon {
  late String totalDuration = '';
  late String totalDistance = '';
  late int totalProblemNum = 0;

  PatrolTotalSon();

  factory PatrolTotalSon.fromJson(Map<String, dynamic> json) =>
      $PatrolTotalSonFromJson(json);

  Map<String, dynamic> toJson() => $PatrolTotalSonToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
