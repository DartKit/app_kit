import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/key_vars.dart';

KeyVars $KeyVarsFromJson(Map<String, dynamic> json) {
  final KeyVars keyVars = KeyVars();
  final bool? select = jsonConvert.convert<bool>(json['select']);
  if (select != null) {
    keyVars.select = select;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    keyVars.id = id;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    keyVars.label = label;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    keyVars.name = name;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    keyVars.value = value;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    keyVars.title = title;
  }
  final String? pid = jsonConvert.convert<String>(json['pid']);
  if (pid != null) {
    keyVars.pid = pid;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    keyVars.code = code;
  }
  final List<KeyVars>? children = (json['children'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<KeyVars>(e) as KeyVars).toList();
  if (children != null) {
    keyVars.children = children;
  }
  return keyVars;
}

Map<String, dynamic> $KeyVarsToJson(KeyVars entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['select'] = entity.select;
  data['id'] = entity.id;
  data['label'] = entity.label;
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['title'] = entity.title;
  data['pid'] = entity.pid;
  data['code'] = entity.code;
  data['children'] = entity.children.map((v) => v.toJson()).toList();
  return data;
}

extension KeyVarsExtension on KeyVars {
  KeyVars copyWith({
    bool? select,
    String? id,
    String? label,
    String? name,
    String? value,
    String? title,
    String? pid,
    String? code,
    List<KeyVars>? children,
  }) {
    return KeyVars()
      ..select = select ?? this.select
      ..id = id ?? this.id
      ..label = label ?? this.label
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..title = title ?? this.title
      ..pid = pid ?? this.pid
      ..code = code ?? this.code
      ..children = children ?? this.children;
  }
}