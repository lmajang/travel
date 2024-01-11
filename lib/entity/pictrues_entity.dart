import 'package:travel/generated/json/base/json_field.dart';
import 'package:travel/generated/json/pictrues_entity.g.dart';
import 'dart:convert';
export 'package:travel/generated/json/pictrues_entity.g.dart';

@JsonSerializable()
class PictruesEntity {
	late List<dynamic> pictrues;

	PictruesEntity();

	factory PictruesEntity.fromJson(Map<String, dynamic> json) => $PictruesEntityFromJson(json);

	Map<String, dynamic> toJson() => $PictruesEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}