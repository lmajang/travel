import 'package:travel/generated/json/base/json_convert_content.dart';
import 'package:travel/entity/vision_screen_data_entity.dart';

VisionScreenDataEntity $VisionScreenDataEntityFromJson(
    Map<String, dynamic> json) {
  final VisionScreenDataEntity visionScreenDataEntity = VisionScreenDataEntity();
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    visionScreenDataEntity.description = description;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    visionScreenDataEntity.latitude = latitude;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    visionScreenDataEntity.longitude = longitude;
  }
  final String? sceneryid = jsonConvert.convert<String>(json['sceneryid']);
  if (sceneryid != null) {
    visionScreenDataEntity.sceneryid = sceneryid;
  }
  final String? sceneryname = jsonConvert.convert<String>(json['sceneryname']);
  if (sceneryname != null) {
    visionScreenDataEntity.sceneryname = sceneryname;
  }
  final int? support = jsonConvert.convert<int>(json['support']);
  if (support != null) {
    visionScreenDataEntity.support = support;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    visionScreenDataEntity.time = time;
  }
  final String? userid = jsonConvert.convert<String>(json['userid']);
  if (userid != null) {
    visionScreenDataEntity.userid = userid;
  }
  return visionScreenDataEntity;
}

Map<String, dynamic> $VisionScreenDataEntityToJson(
    VisionScreenDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['description'] = entity.description;
  data['latitude'] = entity.latitude;
  data['longitude'] = entity.longitude;
  data['sceneryid'] = entity.sceneryid;
  data['sceneryname'] = entity.sceneryname;
  data['support'] = entity.support;
  data['time'] = entity.time;
  data['userid'] = entity.userid;
  return data;
}

extension VisionScreenDataEntityExtension on VisionScreenDataEntity {
  VisionScreenDataEntity copyWith({
    String? description,
    String? latitude,
    String? longitude,
    String? sceneryid,
    String? sceneryname,
    int? support,
    String? time,
    String? userid,
  }) {
    return VisionScreenDataEntity()
      ..description = description ?? this.description
      ..latitude = latitude ?? this.latitude
      ..longitude = longitude ?? this.longitude
      ..sceneryid = sceneryid ?? this.sceneryid
      ..sceneryname = sceneryname ?? this.sceneryname
      ..support = support ?? this.support
      ..time = time ?? this.time
      ..userid = userid ?? this.userid;
  }
}