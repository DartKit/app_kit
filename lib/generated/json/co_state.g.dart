import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/co_state.dart';

CoState $CoStateFromJson(Map<String, dynamic> json) {
  final CoState coState = CoState();
  final bool? state = jsonConvert.convert<bool>(json['state']);
  if (state != null) {
    coState.state = state;
  }
  return coState;
}

Map<String, dynamic> $CoStateToJson(CoState entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['state'] = entity.state;
  return data;
}

extension CoStateExtension on CoState {
  CoState copyWith({
    bool? state,
  }) {
    return CoState()
      ..state = state ?? this.state;
  }
}