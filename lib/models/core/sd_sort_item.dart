import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/sd_sort_item.g.dart';
import 'dart:convert';

@JsonSerializable()
class SdSortItem {
  late dynamic id = 0;
  late int value = 0;
  late int num = 0;
  late int support_patrol = 0; //support_patrol  10 支持巡查  20 不支持
  late int biz_type = 0;
  late String label = '';
  late String name = '';
  late String url = '';

  late int type = 0;
  late int patrol_type_id = 0;
  late int patrol_mode = 0;
  late bool select = false;
  late bool me_add = false;
  late String score = '';
  late String created_at = '';
  late String user_id = '';
  late String real_name = '';
  // late String remark = '';
  late String title = '';
  late String color = '';

  late int evaluate_id = 0;
  late String evaluate_name = '';
  late List<SdSortItem> list = [];

  SdSortItem();

  factory SdSortItem.fromJson(Map<String, dynamic> json) =>
      $SdSortItemFromJson(json);

  Map<String, dynamic> toJson() => $SdSortItemToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
