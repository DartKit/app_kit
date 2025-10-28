import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/oss_obj.dart';

OssObj $OssObjFromJson(Map<String, dynamic> json) {
  final OssObj ossObj = OssObj();
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    ossObj.uid = uid;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    ossObj.url = url;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    ossObj.size = size;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    ossObj.name = name;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    ossObj.type = type;
  }
  final String? thumbUrl = jsonConvert.convert<String>(json['thumbUrl']);
  if (thumbUrl != null) {
    ossObj.thumbUrl = thumbUrl;
  }
  return ossObj;
}

Map<String, dynamic> $OssObjToJson(OssObj entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['uid'] = entity.uid;
  data['url'] = entity.url;
  data['size'] = entity.size;
  data['name'] = entity.name;
  data['type'] = entity.type;
  data['thumbUrl'] = entity.thumbUrl;
  return data;
}

extension OssObjExtension on OssObj {
  OssObj copyWith({
    String? uid,
    String? url,
    int? size,
    String? name,
    String? type,
    String? thumbUrl,
  }) {
    return OssObj()
      ..uid = uid ?? this.uid
      ..url = url ?? this.url
      ..size = size ?? this.size
      ..name = name ?? this.name
      ..type = type ?? this.type
      ..thumbUrl = thumbUrl ?? this.thumbUrl;
  }
}