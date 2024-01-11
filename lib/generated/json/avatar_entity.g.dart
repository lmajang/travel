import 'package:travel/generated/json/base/json_convert_content.dart';
import 'package:travel/entity/avatar_entity.dart';

AvatarEntity $AvatarEntityFromJson(Map<String, dynamic> json) {
  final AvatarEntity avatarEntity = AvatarEntity();
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    avatarEntity.avatar = avatar;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    avatarEntity.name = name;
  }
  final String? userid = jsonConvert.convert<String>(json['userid']);
  if (userid != null) {
    avatarEntity.userid = userid;
  }
  return avatarEntity;
}

Map<String, dynamic> $AvatarEntityToJson(AvatarEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar'] = entity.avatar;
  data['name'] = entity.name;
  data['userid'] = entity.userid;
  return data;
}

extension AvatarEntityExtension on AvatarEntity {
  AvatarEntity copyWith({
    String? avatar,
    String? name,
    String? userid,
  }) {
    return AvatarEntity()
      ..avatar = avatar ?? this.avatar
      ..name = name ?? this.name
      ..userid = userid ?? this.userid;
  }
}