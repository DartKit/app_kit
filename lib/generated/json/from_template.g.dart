import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/from_template.dart';

FromTemplate $FromTemplateFromJson(Map<String, dynamic> json) {
  final FromTemplate fromTemplate = FromTemplate();
  final TemplateInfo? info = jsonConvert.convert<TemplateInfo>(json['info']);
  if (info != null) {
    fromTemplate.info = info;
  }
  final List<FromTemplateList>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FromTemplateList>(e) as FromTemplateList).toList();
  if (list != null) {
    fromTemplate.list = list;
  }
  final List<FromTemplateList>? ai = (json['ai'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FromTemplateList>(e) as FromTemplateList).toList();
  if (ai != null) {
    fromTemplate.ai = ai;
  }
  final List<FromTemplateList>? hot = (json['hot'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FromTemplateList>(e) as FromTemplateList).toList();
  if (hot != null) {
    fromTemplate.hot = hot;
  }
  return fromTemplate;
}

Map<String, dynamic> $FromTemplateToJson(FromTemplate entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['info'] = entity.info.toJson();
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['ai'] = entity.ai.map((v) => v.toJson()).toList();
  data['hot'] = entity.hot.map((v) => v.toJson()).toList();
  return data;
}

extension FromTemplateExtension on FromTemplate {
  FromTemplate copyWith({
    TemplateInfo? info,
    List<FromTemplateList>? list,
    List<FromTemplateList>? ai,
    List<FromTemplateList>? hot,
  }) {
    return FromTemplate()
      ..info = info ?? this.info
      ..list = list ?? this.list
      ..ai = ai ?? this.ai
      ..hot = hot ?? this.hot;
  }
}

FromTemplateList $FromTemplateListFromJson(Map<String, dynamic> json) {
  final FromTemplateList fromTemplateList = FromTemplateList();
  final String? field_type_text = jsonConvert.convert<String>(json['field_type_text']);
  if (field_type_text != null) {
    fromTemplateList.field_type_text = field_type_text;
  }
  final String? field_title = jsonConvert.convert<String>(json['field_title']);
  if (field_title != null) {
    fromTemplateList.field_title = field_title;
  }
  final String? field_code = jsonConvert.convert<String>(json['field_code']);
  if (field_code != null) {
    fromTemplateList.field_code = field_code;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    fromTemplateList.id = id;
  }
  final int? parent_id = jsonConvert.convert<int>(json['parent_id']);
  if (parent_id != null) {
    fromTemplateList.parent_id = parent_id;
  }
  final int? template_id = jsonConvert.convert<int>(json['template_id']);
  if (template_id != null) {
    fromTemplateList.template_id = template_id;
  }
  final int? user_id = jsonConvert.convert<int>(json['user_id']);
  if (user_id != null) {
    fromTemplateList.user_id = user_id;
  }
  final int? node_id = jsonConvert.convert<int>(json['node_id']);
  if (node_id != null) {
    fromTemplateList.node_id = node_id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    fromTemplateList.title = title;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    fromTemplateList.remark = remark;
  }
  final String? reason = jsonConvert.convert<String>(json['reason']);
  if (reason != null) {
    fromTemplateList.reason = reason;
  }
  final String? hint = jsonConvert.convert<String>(json['hint']);
  if (hint != null) {
    fromTemplateList.hint = hint;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    fromTemplateList.name = name;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    fromTemplateList.label = label;
  }
  final String? lable = jsonConvert.convert<String>(json['lable']);
  if (lable != null) {
    fromTemplateList.lable = lable;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    fromTemplateList.type = type;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    fromTemplateList.url = url;
  }
  final String? show_var = jsonConvert.convert<String>(json['show_var']);
  if (show_var != null) {
    fromTemplateList.show_var = show_var;
  }
  final String? check_box = jsonConvert.convert<String>(json['check_box']);
  if (check_box != null) {
    fromTemplateList.check_box = check_box;
  }
  final String? fill_op_type = jsonConvert.convert<String>(json['fill_op_type']);
  if (fill_op_type != null) {
    fromTemplateList.fill_op_type = fill_op_type;
  }
  final String? fill_api = jsonConvert.convert<String>(json['fill_api']);
  if (fill_api != null) {
    fromTemplateList.fill_api = fill_api;
  }
  final String? fill_key = jsonConvert.convert<String>(json['fill_key']);
  if (fill_key != null) {
    fromTemplateList.fill_key = fill_key;
  }
  final String? fill_key_id = jsonConvert.convert<String>(json['fill_key_id']);
  if (fill_key_id != null) {
    fromTemplateList.fill_key_id = fill_key_id;
  }
  final String? check_yes = jsonConvert.convert<String>(json['check_yes']);
  if (check_yes != null) {
    fromTemplateList.check_yes = check_yes;
  }
  final String? fa_key = jsonConvert.convert<String>(json['fa_key']);
  if (fa_key != null) {
    fromTemplateList.fa_key = fa_key;
  }
  final String? fa_var = jsonConvert.convert<String>(json['fa_var']);
  if (fa_var != null) {
    fromTemplateList.fa_var = fa_var;
  }
  final bool? checked = jsonConvert.convert<bool>(json['checked']);
  if (checked != null) {
    fromTemplateList.checked = checked;
  }
  final int? is_required = jsonConvert.convert<int>(json['is_required']);
  if (is_required != null) {
    fromTemplateList.is_required = is_required;
  }
  final int? is_search = jsonConvert.convert<int>(json['is_search']);
  if (is_search != null) {
    fromTemplateList.is_search = is_search;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    fromTemplateList.sort = sort;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    fromTemplateList.status = status;
  }
  final String? created_at = jsonConvert.convert<String>(json['created_at']);
  if (created_at != null) {
    fromTemplateList.created_at = created_at;
  }
  final String? op_time = jsonConvert.convert<String>(json['op_time']);
  if (op_time != null) {
    fromTemplateList.op_time = op_time;
  }
  final String? op_user = jsonConvert.convert<String>(json['op_user']);
  if (op_user != null) {
    fromTemplateList.op_user = op_user;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    fromTemplateList.code = code;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    fromTemplateList.time = time;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    fromTemplateList.score = score;
  }
  final String? max_score = jsonConvert.convert<String>(json['max_score']);
  if (max_score != null) {
    fromTemplateList.max_score = max_score;
  }
  final String? top_score_sort_id = jsonConvert.convert<String>(json['top_score_sort_id']);
  if (top_score_sort_id != null) {
    fromTemplateList.top_score_sort_id = top_score_sort_id;
  }
  final bool? select = jsonConvert.convert<bool>(json['select']);
  if (select != null) {
    fromTemplateList.select = select;
  }
  final bool? showing = jsonConvert.convert<bool>(json['showing']);
  if (showing != null) {
    fromTemplateList.showing = showing;
  }
  final String? tip = jsonConvert.convert<String>(json['tip']);
  if (tip != null) {
    fromTemplateList.tip = tip;
  }
  final String? sel_value = jsonConvert.convert<String>(json['sel_value']);
  if (sel_value != null) {
    fromTemplateList.sel_value = sel_value;
  }
  final String? sel_value_id = jsonConvert.convert<String>(json['sel_value_id']);
  if (sel_value_id != null) {
    fromTemplateList.sel_value_id = sel_value_id;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    fromTemplateList.address = address;
  }
  final String? start_time = jsonConvert.convert<String>(json['start_time']);
  if (start_time != null) {
    fromTemplateList.start_time = start_time;
  }
  final String? end_time = jsonConvert.convert<String>(json['end_time']);
  if (end_time != null) {
    fromTemplateList.end_time = end_time;
  }
  final int? start_interval = jsonConvert.convert<int>(json['start_interval']);
  if (start_interval != null) {
    fromTemplateList.start_interval = start_interval;
  }
  final int? end_interval = jsonConvert.convert<int>(json['end_interval']);
  if (end_interval != null) {
    fromTemplateList.end_interval = end_interval;
  }
  final String? biz_type = jsonConvert.convert<String>(json['biz_type']);
  if (biz_type != null) {
    fromTemplateList.biz_type = biz_type;
  }
  final String? total_score = jsonConvert.convert<String>(json['total_score']);
  if (total_score != null) {
    fromTemplateList.total_score = total_score;
  }
  final List<FromTemplateList>? children = (json['children'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FromTemplateList>(e) as FromTemplateList).toList();
  if (children != null) {
    fromTemplateList.children = children;
  }
  final dynamic value_id = json['value_id'];
  if (value_id != null) {
    fromTemplateList.value_id = value_id;
  }
  final dynamic value = json['value'];
  if (value != null) {
    fromTemplateList.value = value;
  }
  final dynamic valueLs = json['valueLs'];
  if (valueLs != null) {
    fromTemplateList.valueLs = valueLs;
  }
  final List<FromTemplateList>? dats = (json['dats'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FromTemplateList>(e) as FromTemplateList).toList();
  if (dats != null) {
    fromTemplateList.dats = dats;
  }
  final List<FromTemplateList>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FromTemplateList>(e) as FromTemplateList).toList();
  if (list != null) {
    fromTemplateList.list = list;
  }
  final List? select_data = (json['select_data'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (select_data != null) {
    fromTemplateList.select_data = select_data;
  }
  return fromTemplateList;
}

Map<String, dynamic> $FromTemplateListToJson(FromTemplateList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['field_type_text'] = entity.field_type_text;
  data['field_title'] = entity.field_title;
  data['field_code'] = entity.field_code;
  data['id'] = entity.id;
  data['parent_id'] = entity.parent_id;
  data['template_id'] = entity.template_id;
  data['user_id'] = entity.user_id;
  data['node_id'] = entity.node_id;
  data['title'] = entity.title;
  data['remark'] = entity.remark;
  data['reason'] = entity.reason;
  data['hint'] = entity.hint;
  data['name'] = entity.name;
  data['label'] = entity.label;
  data['lable'] = entity.lable;
  data['type'] = entity.type;
  data['url'] = entity.url;
  data['show_var'] = entity.show_var;
  data['check_box'] = entity.check_box;
  data['fill_op_type'] = entity.fill_op_type;
  data['fill_api'] = entity.fill_api;
  data['fill_key'] = entity.fill_key;
  data['fill_key_id'] = entity.fill_key_id;
  data['check_yes'] = entity.check_yes;
  data['fa_key'] = entity.fa_key;
  data['fa_var'] = entity.fa_var;
  data['checked'] = entity.checked;
  data['is_required'] = entity.is_required;
  data['is_search'] = entity.is_search;
  data['sort'] = entity.sort;
  data['status'] = entity.status;
  data['created_at'] = entity.created_at;
  data['op_time'] = entity.op_time;
  data['op_user'] = entity.op_user;
  data['code'] = entity.code;
  data['time'] = entity.time;
  data['score'] = entity.score;
  data['max_score'] = entity.max_score;
  data['top_score_sort_id'] = entity.top_score_sort_id;
  data['select'] = entity.select;
  data['showing'] = entity.showing;
  data['tip'] = entity.tip;
  data['sel_value'] = entity.sel_value;
  data['sel_value_id'] = entity.sel_value_id;
  data['address'] = entity.address;
  data['start_time'] = entity.start_time;
  data['end_time'] = entity.end_time;
  data['start_interval'] = entity.start_interval;
  data['end_interval'] = entity.end_interval;
  data['biz_type'] = entity.biz_type;
  data['total_score'] = entity.total_score;
  data['children'] = entity.children.map((v) => v.toJson()).toList();
  data['value_id'] = entity.value_id;
  data['value'] = entity.value;
  data['valueLs'] = entity.valueLs;
  data['dats'] = entity.dats.map((v) => v.toJson()).toList();
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['select_data'] = entity.select_data;
  return data;
}

extension FromTemplateListExtension on FromTemplateList {
  FromTemplateList copyWith({
    String? field_type_text,
    String? field_title,
    String? field_code,
    int? id,
    int? parent_id,
    int? template_id,
    int? user_id,
    int? node_id,
    String? title,
    String? remark,
    String? reason,
    String? hint,
    String? name,
    String? label,
    String? lable,
    String? type,
    String? url,
    String? show_var,
    String? check_box,
    String? fill_op_type,
    String? fill_api,
    String? fill_key,
    String? fill_key_id,
    String? check_yes,
    String? fa_key,
    String? fa_var,
    bool? checked,
    int? is_required,
    int? is_search,
    int? sort,
    int? status,
    String? created_at,
    String? op_time,
    String? op_user,
    String? code,
    String? time,
    String? score,
    String? max_score,
    String? top_score_sort_id,
    bool? select,
    bool? showing,
    String? tip,
    String? sel_value,
    String? sel_value_id,
    String? address,
    String? start_time,
    String? end_time,
    int? start_interval,
    int? end_interval,
    String? biz_type,
    String? total_score,
    List<FromTemplateList>? children,
    dynamic value_id,
    dynamic value,
    dynamic valueLs,
    List<FromTemplateList>? dats,
    List<FromTemplateList>? list,
    List? select_data,
  }) {
    return FromTemplateList()
      ..field_type_text = field_type_text ?? this.field_type_text
      ..field_title = field_title ?? this.field_title
      ..field_code = field_code ?? this.field_code
      ..id = id ?? this.id
      ..parent_id = parent_id ?? this.parent_id
      ..template_id = template_id ?? this.template_id
      ..user_id = user_id ?? this.user_id
      ..node_id = node_id ?? this.node_id
      ..title = title ?? this.title
      ..remark = remark ?? this.remark
      ..reason = reason ?? this.reason
      ..hint = hint ?? this.hint
      ..name = name ?? this.name
      ..label = label ?? this.label
      ..lable = lable ?? this.lable
      ..type = type ?? this.type
      ..url = url ?? this.url
      ..show_var = show_var ?? this.show_var
      ..check_box = check_box ?? this.check_box
      ..fill_op_type = fill_op_type ?? this.fill_op_type
      ..fill_api = fill_api ?? this.fill_api
      ..fill_key = fill_key ?? this.fill_key
      ..fill_key_id = fill_key_id ?? this.fill_key_id
      ..check_yes = check_yes ?? this.check_yes
      ..fa_key = fa_key ?? this.fa_key
      ..fa_var = fa_var ?? this.fa_var
      ..checked = checked ?? this.checked
      ..is_required = is_required ?? this.is_required
      ..is_search = is_search ?? this.is_search
      ..sort = sort ?? this.sort
      ..status = status ?? this.status
      ..created_at = created_at ?? this.created_at
      ..op_time = op_time ?? this.op_time
      ..op_user = op_user ?? this.op_user
      ..code = code ?? this.code
      ..time = time ?? this.time
      ..score = score ?? this.score
      ..max_score = max_score ?? this.max_score
      ..top_score_sort_id = top_score_sort_id ?? this.top_score_sort_id
      ..select = select ?? this.select
      ..showing = showing ?? this.showing
      ..tip = tip ?? this.tip
      ..sel_value = sel_value ?? this.sel_value
      ..sel_value_id = sel_value_id ?? this.sel_value_id
      ..address = address ?? this.address
      ..start_time = start_time ?? this.start_time
      ..end_time = end_time ?? this.end_time
      ..start_interval = start_interval ?? this.start_interval
      ..end_interval = end_interval ?? this.end_interval
      ..biz_type = biz_type ?? this.biz_type
      ..total_score = total_score ?? this.total_score
      ..children = children ?? this.children
      ..value_id = value_id ?? this.value_id
      ..value = value ?? this.value
      ..valueLs = valueLs ?? this.valueLs
      ..dats = dats ?? this.dats
      ..list = list ?? this.list
      ..select_data = select_data ?? this.select_data;
  }
}

TemplateInfo $TemplateInfoFromJson(Map<String, dynamic> json) {
  final TemplateInfo templateInfo = TemplateInfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    templateInfo.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    templateInfo.name = name;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    templateInfo.code = code;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    templateInfo.remark = remark;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    templateInfo.type = type;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    templateInfo.url = url;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    templateInfo.status = status;
  }
  final bool? show_map = jsonConvert.convert<bool>(json['show_map']);
  if (show_map != null) {
    templateInfo.show_map = show_map;
  }
  return templateInfo;
}

Map<String, dynamic> $TemplateInfoToJson(TemplateInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['code'] = entity.code;
  data['remark'] = entity.remark;
  data['type'] = entity.type;
  data['url'] = entity.url;
  data['status'] = entity.status;
  data['show_map'] = entity.show_map;
  return data;
}

extension TemplateInfoExtension on TemplateInfo {
  TemplateInfo copyWith({
    int? id,
    String? name,
    String? code,
    String? remark,
    String? type,
    String? url,
    int? status,
    bool? show_map,
  }) {
    return TemplateInfo()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..code = code ?? this.code
      ..remark = remark ?? this.remark
      ..type = type ?? this.type
      ..url = url ?? this.url
      ..status = status ?? this.status
      ..show_map = show_map ?? this.show_map;
  }
}