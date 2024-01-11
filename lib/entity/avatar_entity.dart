import 'package:travel/generated/json/base/json_field.dart';
import 'package:travel/generated/json/avatar_entity.g.dart';
import 'dart:convert';
export 'package:travel/generated/json/avatar_entity.g.dart';

@JsonSerializable()
class AvatarEntity {
	late String avatar;
	late String name;
	late String userid;

	AvatarEntity();

	factory AvatarEntity.fromJson(Map<String, dynamic> json) => $AvatarEntityFromJson(json);

	Map<String, dynamic> toJson() => $AvatarEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}