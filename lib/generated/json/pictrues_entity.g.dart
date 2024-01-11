import 'package:travel/generated/json/base/json_convert_content.dart';
import 'package:travel/entity/pictrues_entity.dart';

PictruesEntity $PictruesEntityFromJson(Map<String, dynamic> json) {
  final PictruesEntity pictruesEntity = PictruesEntity();
  final List<dynamic>? pictrues = (json['pictrues'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (pictrues != null) {
    pictruesEntity.pictrues = pictrues;
  }
  return pictruesEntity;
}

Map<String, dynamic> $PictruesEntityToJson(PictruesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pictrues'] = entity.pictrues;
  return data;
}

extension PictruesEntityExtension on PictruesEntity {
  PictruesEntity copyWith({
    List<dynamic>? pictrues,
  }) {
    return PictruesEntity()
      ..pictrues = pictrues ?? this.pictrues;
  }
}