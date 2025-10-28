import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/oss_token.dart';

OssToken $OssTokenFromJson(Map<String, dynamic> json) {
  final OssToken ossToken = OssToken();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    ossToken.id = id;
  }
  final String? host = jsonConvert.convert<String>(json['host']);
  if (host != null) {
    ossToken.host = host;
  }
  final String? policy = jsonConvert.convert<String>(json['policy']);
  if (policy != null) {
    ossToken.policy = policy;
  }
  final String? signature = jsonConvert.convert<String>(json['signature']);
  if (signature != null) {
    ossToken.signature = signature;
  }
  final int? expire = jsonConvert.convert<int>(json['expire']);
  if (expire != null) {
    ossToken.expire = expire;
  }
  final String? callback = jsonConvert.convert<String>(json['callback']);
  if (callback != null) {
    ossToken.callback = callback;
  }
  final String? dir = jsonConvert.convert<String>(json['dir']);
  if (dir != null) {
    ossToken.dir = dir;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    ossToken.path = path;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    ossToken.url = url;
  }
  return ossToken;
}

Map<String, dynamic> $OssTokenToJson(OssToken entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['host'] = entity.host;
  data['policy'] = entity.policy;
  data['signature'] = entity.signature;
  data['expire'] = entity.expire;
  data['callback'] = entity.callback;
  data['dir'] = entity.dir;
  data['path'] = entity.path;
  data['url'] = entity.url;
  return data;
}

extension OssTokenExtension on OssToken {
  OssToken copyWith({
    String? id,
    String? host,
    String? policy,
    String? signature,
    int? expire,
    String? callback,
    String? dir,
    String? path,
    String? url,
  }) {
    return OssToken()
      ..id = id ?? this.id
      ..host = host ?? this.host
      ..policy = policy ?? this.policy
      ..signature = signature ?? this.signature
      ..expire = expire ?? this.expire
      ..callback = callback ?? this.callback
      ..dir = dir ?? this.dir
      ..path = path ?? this.path
      ..url = url ?? this.url;
  }
}