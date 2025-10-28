import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/sd_sort_item.dart';

SdSortItem $SdSortItemFromJson(Map<String, dynamic> json) {
  final SdSortItem sdSortItem = SdSortItem();
  final dynamic id = json['id'];
  if (id != null) {
    sdSortItem.id = id;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    sdSortItem.value = value;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    sdSortItem.num = num;
  }
  final int? support_patrol = jsonConvert.convert<int>(json['support_patrol']);
  if (support_patrol != null) {
    sdSortItem.support_patrol = support_patrol;
  }
  final int? biz_type = jsonConvert.convert<int>(json['biz_type']);
  if (biz_type != null) {
    sdSortItem.biz_type = biz_type;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    sdSortItem.label = label;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    sdSortItem.name = name;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    sdSortItem.url = url;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    sdSortItem.type = type;
  }
  final int? patrol_type_id = jsonConvert.convert<int>(json['patrol_type_id']);
  if (patrol_type_id != null) {
    sdSortItem.patrol_type_id = patrol_type_id;
  }
  final int? patrol_mode = jsonConvert.convert<int>(json['patrol_mode']);
  if (patrol_mode != null) {
    sdSortItem.patrol_mode = patrol_mode;
  }
  final bool? select = jsonConvert.convert<bool>(json['select']);
  if (select != null) {
    sdSortItem.select = select;
  }
  final bool? me_add = jsonConvert.convert<bool>(json['me_add']);
  if (me_add != null) {
    sdSortItem.me_add = me_add;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    sdSortItem.score = score;
  }
  final String? created_at = jsonConvert.convert<String>(json['created_at']);
  if (created_at != null) {
    sdSortItem.created_at = created_at;
  }
  final String? user_id = jsonConvert.convert<String>(json['user_id']);
  if (user_id != null) {
    sdSortItem.user_id = user_id;
  }
  final String? real_name = jsonConvert.convert<String>(json['real_name']);
  if (real_name != null) {
    sdSortItem.real_name = real_name;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    sdSortItem.title = title;
  }
  final String? color = jsonConvert.convert<String>(json['color']);
  if (color != null) {
    sdSortItem.color = color;
  }
  final int? evaluate_id = jsonConvert.convert<int>(json['evaluate_id']);
  if (evaluate_id != null) {
    sdSortItem.evaluate_id = evaluate_id;
  }
  final String? evaluate_name = jsonConvert.convert<String>(json['evaluate_name']);
  if (evaluate_name != null) {
    sdSortItem.evaluate_name = evaluate_name;
  }
  final List<SdSortItem>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<SdSortItem>(e) as SdSortItem).toList();
  if (list != null) {
    sdSortItem.list = list;
  }
  return sdSortItem;
}

Map<String, dynamic> $SdSortItemToJson(SdSortItem entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['value'] = entity.value;
  data['num'] = entity.num;
  data['support_patrol'] = entity.support_patrol;
  data['biz_type'] = entity.biz_type;
  data['label'] = entity.label;
  data['name'] = entity.name;
  data['url'] = entity.url;
  data['type'] = entity.type;
  data['patrol_type_id'] = entity.patrol_type_id;
  data['patrol_mode'] = entity.patrol_mode;
  data['select'] = entity.select;
  data['me_add'] = entity.me_add;
  data['score'] = entity.score;
  data['created_at'] = entity.created_at;
  data['user_id'] = entity.user_id;
  data['real_name'] = entity.real_name;
  data['title'] = entity.title;
  data['color'] = entity.color;
  data['evaluate_id'] = entity.evaluate_id;
  data['evaluate_name'] = entity.evaluate_name;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension SdSortItemExtension on SdSortItem {
  SdSortItem copyWith({
    dynamic id,
    int? value,
    int? num,
    int? support_patrol,
    int? biz_type,
    String? label,
    String? name,
    String? url,
    int? type,
    int? patrol_type_id,
    int? patrol_mode,
    bool? select,
    bool? me_add,
    String? score,
    String? created_at,
    String? user_id,
    String? real_name,
    String? title,
    String? color,
    int? evaluate_id,
    String? evaluate_name,
    List<SdSortItem>? list,
  }) {
    return SdSortItem()
      ..id = id ?? this.id
      ..value = value ?? this.value
      ..num = num ?? this.num
      ..support_patrol = support_patrol ?? this.support_patrol
      ..biz_type = biz_type ?? this.biz_type
      ..label = label ?? this.label
      ..name = name ?? this.name
      ..url = url ?? this.url
      ..type = type ?? this.type
      ..patrol_type_id = patrol_type_id ?? this.patrol_type_id
      ..patrol_mode = patrol_mode ?? this.patrol_mode
      ..select = select ?? this.select
      ..me_add = me_add ?? this.me_add
      ..score = score ?? this.score
      ..created_at = created_at ?? this.created_at
      ..user_id = user_id ?? this.user_id
      ..real_name = real_name ?? this.real_name
      ..title = title ?? this.title
      ..color = color ?? this.color
      ..evaluate_id = evaluate_id ?? this.evaluate_id
      ..evaluate_name = evaluate_name ?? this.evaluate_name
      ..list = list ?? this.list;
  }
}