import 'package:travel/generated/json/base/json_field.dart';
import 'package:travel/generated/json/vision_screen_data_entity.g.dart';
import 'dart:convert';
export 'package:travel/generated/json/vision_screen_data_entity.g.dart';

@JsonSerializable()
class VisionScreenDataEntity {
	String? description;
	String? latitude;
	String? longitude;
	String? sceneryid;
	String? sceneryname;
	int? support;
	String? time;
	String? userid;

	VisionScreenDataEntity();

	factory VisionScreenDataEntity.fromJson(Map<String, dynamic> json) => $VisionScreenDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $VisionScreenDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}