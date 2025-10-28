import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/common_ver.dart';
import 'package:app_kit/models/core/oss_obj.dart';


CommonVer $CommonVerFromJson(Map<String, dynamic> json) {
  final CommonVer commonVer = CommonVer();
  final CommonVerVersion? info = jsonConvert.convert<CommonVerVersion>(json['info']);
  if (info != null) {
    commonVer.info = info;
  }
  return commonVer;
}

Map<String, dynamic> $CommonVerToJson(CommonVer entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['info'] = entity.info.toJson();
  return data;
}

extension CommonVerExtension on CommonVer {
  CommonVer copyWith({
    CommonVerVersion? info,
  }) {
    return CommonVer()
      ..info = info ?? this.info;
  }
}

CommonVerVersion $CommonVerVersionFromJson(Map<String, dynamic> json) {
  final CommonVerVersion commonVerVersion = CommonVerVersion();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    commonVerVersion.name = name;
  }
  final String? version = jsonConvert.convert<String>(json['version']);
  if (version != null) {
    commonVerVersion.version = version;
  }
  final List<OssObj>? url = (json['url'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<OssObj>(e) as OssObj).toList();
  if (url != null) {
    commonVerVersion.url = url;
  }
  final String? created_at = jsonConvert.convert<String>(json['created_at']);
  if (created_at != null) {
    commonVerVersion.created_at = created_at;
  }
  final List<String>? remark = (json['remark'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (remark != null) {
    commonVerVersion.remark = remark;
  }
  final List<int>? project_list = (json['project_list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (project_list != null) {
    commonVerVersion.project_list = project_list;
  }
  final List<ChannelVer>? channels = (json['channels'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ChannelVer>(e) as ChannelVer).toList();
  if (channels != null) {
    commonVerVersion.channels = channels;
  }
  final String? ios_version = jsonConvert.convert<String>(json['ios_version']);
  if (ios_version != null) {
    commonVerVersion.ios_version = ios_version;
  }
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    commonVerVersion.code = code;
  }
  final int? ios_code = jsonConvert.convert<int>(json['ios_code']);
  if (ios_code != null) {
    commonVerVersion.ios_code = ios_code;
  }
  final int? force = jsonConvert.convert<int>(json['force']);
  if (force != null) {
    commonVerVersion.force = force;
  }
  final int? ios_force = jsonConvert.convert<int>(json['ios_force']);
  if (ios_force != null) {
    commonVerVersion.ios_force = ios_force;
  }
  final bool? force_format = jsonConvert.convert<bool>(json['force_format']);
  if (force_format != null) {
    commonVerVersion.force_format = force_format;
  }
  final bool? ios_force_format = jsonConvert.convert<bool>(json['ios_force_format']);
  if (ios_force_format != null) {
    commonVerVersion.ios_force_format = ios_force_format;
  }
  return commonVerVersion;
}

Map<String, dynamic> $CommonVerVersionToJson(CommonVerVersion entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['version'] = entity.version;
  data['url'] = entity.url.map((v) => v.toJson()).toList();
  data['created_at'] = entity.created_at;
  data['remark'] = entity.remark;
  data['project_list'] = entity.project_list;
  data['channels'] = entity.channels.map((v) => v.toJson()).toList();
  data['ios_version'] = entity.ios_version;
  data['code'] = entity.code;
  data['ios_code'] = entity.ios_code;
  data['force'] = entity.force;
  data['ios_force'] = entity.ios_force;
  data['force_format'] = entity.force_format;
  data['ios_force_format'] = entity.ios_force_format;
  return data;
}

extension CommonVerVersionExtension on CommonVerVersion {
  CommonVerVersion copyWith({
    String? name,
    String? version,
    List<OssObj>? url,
    String? created_at,
    List<String>? remark,
    List<int>? project_list,
    List<ChannelVer>? channels,
    String? ios_version,
    int? code,
    int? ios_code,
    int? force,
    int? ios_force,
    bool? force_format,
    bool? ios_force_format,
  }) {
    return CommonVerVersion()
      ..name = name ?? this.name
      ..version = version ?? this.version
      ..url = url ?? this.url
      ..created_at = created_at ?? this.created_at
      ..remark = remark ?? this.remark
      ..project_list = project_list ?? this.project_list
      ..channels = channels ?? this.channels
      ..ios_version = ios_version ?? this.ios_version
      ..code = code ?? this.code
      ..ios_code = ios_code ?? this.ios_code
      ..force = force ?? this.force
      ..ios_force = ios_force ?? this.ios_force
      ..force_format = force_format ?? this.force_format
      ..ios_force_format = ios_force_format ?? this.ios_force_format;
  }
}

ChannelVer $ChannelVerFromJson(Map<String, dynamic> json) {
  final ChannelVer channelVer = ChannelVer();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    channelVer.url = url;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    channelVer.name = name;
  }
  final String? channel = jsonConvert.convert<String>(json['channel']);
  if (channel != null) {
    channelVer.channel = channel;
  }
  return channelVer;
}

Map<String, dynamic> $ChannelVerToJson(ChannelVer entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['name'] = entity.name;
  data['channel'] = entity.channel;
  return data;
}

extension ChannelVerExtension on ChannelVer {
  ChannelVer copyWith({
    String? url,
    String? name,
    String? channel,
  }) {
    return ChannelVer()
      ..url = url ?? this.url
      ..name = name ?? this.name
      ..channel = channel ?? this.channel;
  }
}

PatrolTotalMo $PatrolTotalMoFromJson(Map<String, dynamic> json) {
  final PatrolTotalMo patrolTotalMo = PatrolTotalMo();
  final PatrolTotalSon? info = jsonConvert.convert<PatrolTotalSon>(json['info']);
  if (info != null) {
    patrolTotalMo.info = info;
  }
  return patrolTotalMo;
}

Map<String, dynamic> $PatrolTotalMoToJson(PatrolTotalMo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['info'] = entity.info.toJson();
  return data;
}

extension PatrolTotalMoExtension on PatrolTotalMo {
  PatrolTotalMo copyWith({
    PatrolTotalSon? info,
  }) {
    return PatrolTotalMo()
      ..info = info ?? this.info;
  }
}

PatrolTotalSon $PatrolTotalSonFromJson(Map<String, dynamic> json) {
  final PatrolTotalSon patrolTotalSon = PatrolTotalSon();
  final String? totalDuration = jsonConvert.convert<String>(json['totalDuration']);
  if (totalDuration != null) {
    patrolTotalSon.totalDuration = totalDuration;
  }
  final String? totalDistance = jsonConvert.convert<String>(json['totalDistance']);
  if (totalDistance != null) {
    patrolTotalSon.totalDistance = totalDistance;
  }
  final int? totalProblemNum = jsonConvert.convert<int>(json['totalProblemNum']);
  if (totalProblemNum != null) {
    patrolTotalSon.totalProblemNum = totalProblemNum;
  }
  return patrolTotalSon;
}

Map<String, dynamic> $PatrolTotalSonToJson(PatrolTotalSon entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['totalDuration'] = entity.totalDuration;
  data['totalDistance'] = entity.totalDistance;
  data['totalProblemNum'] = entity.totalProblemNum;
  return data;
}

extension PatrolTotalSonExtension on PatrolTotalSon {
  PatrolTotalSon copyWith({
    String? totalDuration,
    String? totalDistance,
    int? totalProblemNum,
  }) {
    return PatrolTotalSon()
      ..totalDuration = totalDuration ?? this.totalDuration
      ..totalDistance = totalDistance ?? this.totalDistance
      ..totalProblemNum = totalProblemNum ?? this.totalProblemNum;
  }
}