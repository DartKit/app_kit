import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/form_model.dart';
import 'dart:core';

import 'package:app_kit/models/core/sd_search.dart';

import 'package:app_kit/models/core/sd_sort_item.dart';


FormModel $FormModelFromJson(Map<String, dynamic> json) {
  final FormModel formModel = FormModel();
  final List? list = (json['list'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (list != null) {
    formModel.list = list;
  }
  final List? data = (json['data'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (data != null) {
    formModel.data = data;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    formModel.total = total;
  }
  final List<SdSearch>? search = (json['search'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<SdSearch>(e) as SdSearch).toList();
  if (search != null) {
    formModel.search = search;
  }
  final List<SdSortItem>? sort = (json['sort'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<SdSortItem>(e) as SdSortItem).toList();
  if (sort != null) {
    formModel.sort = sort;
  }
  return formModel;
}

Map<String, dynamic> $FormModelToJson(FormModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list;
  data['data'] = entity.data;
  data['total'] = entity.total;
  data['search'] = entity.search.map((v) => v.toJson()).toList();
  data['sort'] = entity.sort.map((v) => v.toJson()).toList();
  return data;
}

extension FormModelExtension on FormModel {
  FormModel copyWith({
    List? list,
    List? data,
    int? total,
    List<SdSearch>? search,
    List<SdSortItem>? sort,
  }) {
    return FormModel()
      ..list = list ?? this.list
      ..data = data ?? this.data
      ..total = total ?? this.total
      ..search = search ?? this.search
      ..sort = sort ?? this.sort;
  }
}