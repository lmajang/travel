import 'package:travel/generated/json/base/json_field.dart';
import 'package:travel/generated/json/upload_date_entity.g.dart';
import 'dart:convert';
export 'package:travel/generated/json/upload_date_entity.g.dart';

@JsonSerializable()
class UploadDateEntity {
	late String datejudge;

	UploadDateEntity();

	factory UploadDateEntity.fromJson(Map<String, dynamic> json) => $UploadDateEntityFromJson(json);

	Map<String, dynamic> toJson() => $UploadDateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}