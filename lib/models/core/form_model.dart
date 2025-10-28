import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/form_model.g.dart';
import 'dart:core';
import 'dart:convert';

import 'package:app_kit/models/core/sd_search.dart';
import 'package:app_kit/models/core/sd_sort_item.dart';

@JsonSerializable()
class FormModel {
  late List list = [];
  late List data = [];
  late int total = 0;
  late List<SdSearch> search = [];
  late List<SdSortItem> sort = [];

  FormModel();

  factory FormModel.fromJson(Map<String, dynamic> json) =>
      $FormModelFromJson(json);

  Map<String, dynamic> toJson() => $FormModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
