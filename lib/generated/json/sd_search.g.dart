import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/sd_search.dart';
import 'package:app_kit/models/core/from_template.dart';


SdSearch $SdSearchFromJson(Map<String, dynamic> json) {
  final SdSearch sdSearch = SdSearch();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    sdSearch.title = title;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    sdSearch.type = type;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    sdSearch.name = name;
  }
  final String? sel_value = jsonConvert.convert<String>(json['sel_value']);
  if (sel_value != null) {
    sdSearch.sel_value = sel_value;
  }
  final int? sel_value_id = jsonConvert.convert<int>(json['sel_value_id']);
  if (sel_value_id != null) {
    sdSearch.sel_value_id = sel_value_id;
  }
  final bool? select = jsonConvert.convert<bool>(json['select']);
  if (select != null) {
    sdSearch.select = select;
  }
  final List<FromTemplateList>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FromTemplateList>(e) as FromTemplateList).toList();
  if (list != null) {
    sdSearch.list = list;
  }
  return sdSearch;
}

Map<String, dynamic> $SdSearchToJson(SdSearch entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['name'] = entity.name;
  data['sel_value'] = entity.sel_value;
  data['sel_value_id'] = entity.sel_value_id;
  data['select'] = entity.select;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension SdSearchExtension on SdSearch {
  SdSearch copyWith({
    String? title,
    String? type,
    String? name,
    String? sel_value,
    int? sel_value_id,
    bool? select,
    List<FromTemplateList>? list,
  }) {
    return SdSearch()
      ..title = title ?? this.title
      ..type = type ?? this.type
      ..name = name ?? this.name
      ..sel_value = sel_value ?? this.sel_value
      ..sel_value_id = sel_value_id ?? this.sel_value_id
      ..select = select ?? this.select
      ..list = list ?? this.list;
  }
}