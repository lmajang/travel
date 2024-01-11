import 'package:travel/generated/json/base/json_field.dart';
import 'package:travel/generated/json/labels_entity.g.dart';
import 'dart:convert';
export 'package:travel/generated/json/labels_entity.g.dart';

@JsonSerializable()
class LabelsEntity {
	late List<LabelsLabels> labels;

	LabelsEntity();

	factory LabelsEntity.fromJson(Map<String, dynamic> json) => $LabelsEntityFromJson(json);

	Map<String, dynamic> toJson() => $LabelsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LabelsLabels {
	String? label;
	String? sceneryid;

	LabelsLabels();

	factory LabelsLabels.fromJson(Map<String, dynamic> json) => $LabelsLabelsFromJson(json);

	Map<String, dynamic> toJson() => $LabelsLabelsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}