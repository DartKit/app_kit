import 'package:app_kit/generated/json/base/json_convert_content.dart';

import '../../core/app_log.dart';
import 'api_response_entity.dart';

KitResponse<T> $ApiResponseFromJson<T>(Map<String, dynamic> json,{String dataKey = '',}) {
  final KitResponse<T> apiResponseEntity = KitResponse<T>();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    apiResponseEntity.code = code;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    apiResponseEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    apiResponseEntity.message = message;
  }

  // print('---json.runtimeType.toString()--${json['data'].runtimeType.toString()}');
  var rsp = json['data'];
  if (dataKey.isNotEmpty &&
      (json['data'].runtimeType.toString().contains('Map')) &&
      (Map.from(json['data']).containsKey(dataKey.split('.').first))
  ) {
    List<String> keys = dataKey.split('.');
    for (var o in keys) {
      if (rsp.containsKey(o)) {
        rsp =  rsp[o];
      }else {
        apiResponseEntity.data = null;
        return apiResponseEntity;
      }
    }
    final T? data = JsonConvert.fromJsonAsT<T>(rsp);
    if (data != null) {
      apiResponseEntity.data = data;
    }

  }else {
    // logs('--data-0-:${json['data']}');
    // if (rsp is List) {
    //
    // } else {
    //   if (JsonConvert().convertFuncMap.containsKey(T.toString()) == false) {
    //
    //   }
    // }

    final T? data = JsonConvert.fromJsonAsT<T>( json['data']);
    if (data != null) {
      apiResponseEntity.data = data;
    }
  }

  return apiResponseEntity;
}

Map<String, dynamic> $ApiResponseToJson(KitResponse entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data;
  return data;
}
