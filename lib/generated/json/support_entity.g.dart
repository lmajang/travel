import 'package:travel/generated/json/base/json_convert_content.dart';
import 'package:travel/entity/support_entity.dart';

SupportEntity $SupportEntityFromJson(Map<String, dynamic> json) {
  final SupportEntity supportEntity = SupportEntity();
  final String? issupport = jsonConvert.convert<String>(json['issupport']);
  if (issupport != null) {
    supportEntity.issupport = issupport;
  }
  return supportEntity;
}

Map<String, dynamic> $SupportEntityToJson(SupportEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['issupport'] = entity.issupport;
  return data;
}

extension SupportEntityExtension on SupportEntity {
  SupportEntity copyWith({
    String? issupport,
  }) {
    return SupportEntity()
      ..issupport = issupport ?? this.issupport;
  }
}