import 'dart:convert';
import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/co_state.g.dart';

@JsonSerializable()
class CoState {
  late bool state;

  CoState();

  factory CoState.fromJson(Map<String, dynamic> json) => $CoStateFromJson(json);

  Map<String, dynamic> toJson() => $CoStateToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
