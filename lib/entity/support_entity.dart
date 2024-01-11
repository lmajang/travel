import 'package:travel/generated/json/base/json_field.dart';
import 'package:travel/generated/json/support_entity.g.dart';
import 'dart:convert';
export 'package:travel/generated/json/support_entity.g.dart';

@JsonSerializable()
class SupportEntity {
	late String issupport;

	SupportEntity();

	factory SupportEntity.fromJson(Map<String, dynamic> json) => $SupportEntityFromJson(json);

	Map<String, dynamic> toJson() => $SupportEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}