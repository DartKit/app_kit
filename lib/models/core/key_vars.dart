import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/key_vars.g.dart';
import 'dart:convert';
export 'package:app_kit/generated/json/key_vars.g.dart';

@JsonSerializable()
class KeyVars {
	int id = 0;
	bool select = false;
	String label = '';
	String value = '';
	String title = '';
	String pid = '';
	String code = '';
	List<KeyVars> children = [];

	KeyVars();

	factory KeyVars.fromJson(Map<String, dynamic> json) => $KeyVarsFromJson(json);

	Map<String, dynamic> toJson() => $KeyVarsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}