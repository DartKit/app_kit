import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/sd_search.g.dart';
import 'dart:convert';

import 'package:app_kit/models/core/from_template.dart';

@JsonSerializable()
class SdSearch {
  late String title = '';
  late String type = '';
  late String name = '';
  // late String current_month = '';
  late String sel_value = '';
  late int sel_value_id = 0;
  late bool select = false;
  late List<FromTemplateList> list = [];

  SdSearch();

  factory SdSearch.fromJson(Map<String, dynamic> json) =>
      $SdSearchFromJson(json);

  Map<String, dynamic> toJson() => $SdSearchToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
