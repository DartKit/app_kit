import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/from_template.g.dart';
import 'dart:convert';

@JsonSerializable()
class FromTemplate {
  late TemplateInfo info = TemplateInfo();
  late List<FromTemplateList> list = [];
  late List<FromTemplateList> ai = [];
  late List<FromTemplateList> hot = [];

  FromTemplate();

  factory FromTemplate.fromJson(Map<String, dynamic> json) =>
      $FromTemplateFromJson(json);

  Map<String, dynamic> toJson() => $FromTemplateToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FromTemplateList {
  late String field_type_text = '';
  late String field_title = '';
  late String field_code = '';

  late int id = 0;
  // late int project_id = 0;
  late int parent_id = 0;
  late int template_id = 0;
  late int user_id = 0;
  late int node_id = 0;
  // late int sch_id = 0;
  // late String sch_id_text = '';
  late String title = '';
  late String remark = '';
  late String reason = '';
  late String hint = '';
  late String name = '';
  late String label = '';
  late String lable = '';
  // late String name_children = ''; // 子级 children 中的入参字段
  late String type = '';
  late String url = '';
  // late String show_name = '';
  late String show_var = '';
  // bool? show_name_tick;
  late String check_box = '';
  late String fill_op_type = '';
  late String fill_api = '';
  late String fill_key = '';
  late String fill_key_id = '';
  late String check_yes = '';
  // late String one_fill = '';
  late String fa_key = '';
  late String fa_var = '';
  bool? checked;
  late int is_required = 0;
  late int is_search = 0;
  late int sort = 0;
  late int status = 0;
  late String created_at = '';
  late String op_time = '';
  late String op_user = '';
  // late String updated_at = '';
  // late String deleted_at = '';
  late String code = '';
  late String time = '';
  late String score = '';
  late String max_score = '';
  late String top_score_sort_id = '';
  late bool select = false;
  late bool showing = false;
  late String tip = '';
  late String sel_value = '';
  late String sel_value_id = '';
  // late String latitude = '';
  // late String longitude = '';
  late String address = '';
  late String start_time = '';
  late String end_time = '';
  // late int is_leader = 0;
  late int start_interval = 0;
  late int end_interval = 0;

  late String biz_type = '';
  late String total_score = '';
  late List<FromTemplateList> children = [];
  // 自己新增的。选中的id 和选中的文案
  dynamic value_id = 0;
  dynamic value;
  dynamic valueLs;
  // dynamic picked;
  late List<FromTemplateList> dats = []; // 自己保存接口数据
  late List<FromTemplateList> list = []; // 某些接口数据
  late List select_data = []; // 自定义表单养护日志下拉数据

  FromTemplateList();

  factory FromTemplateList.fromJson(Map<String, dynamic> json) =>
      $FromTemplateListFromJson(json);

  Map<String, dynamic> toJson() => $FromTemplateListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TemplateInfo {
  late int id = 0;
  late String name = '';
  late String code = '';
  late String remark = '';
  late String type = '';
  late String url = '';
  late int status = 0;
  late bool show_map = false;

  TemplateInfo();

  factory TemplateInfo.fromJson(Map<String, dynamic> json) =>
      $TemplateInfoFromJson(json);

  Map<String, dynamic> toJson() => $TemplateInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
