import 'package:app_kit/generated/json/base/json_convert_content.dart';

import 'api_response_entity.dart';

ApiResponse<T> $ApiResponseFromJson<T>(Map<String, dynamic> json,{String dataKey = '',}) {
  final ApiResponse<T> apiResponseEntity = ApiResponse<T>();
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
  if (dataKey.isNotEmpty &&
      (json['data'].runtimeType.toString().contains('Map')) &&
      (Map.from(json['data']).containsKey(dataKey))
  ) {
    final T? data = JsonConvert.fromJsonAsT<T>( json['data'][dataKey]);
    if (data != null) {
      apiResponseEntity.data = data;
    }

  }else {
    final T? data = JsonConvert.fromJsonAsT<T>( json['data']);
    if (data != null) {
      apiResponseEntity.data = data;
    }
  }

  return apiResponseEntity;
}

Map<String, dynamic> $ApiResponseToJson(ApiResponse entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data;
  return data;
}
