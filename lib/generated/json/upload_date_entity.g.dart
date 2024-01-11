import 'package:travel/generated/json/base/json_convert_content.dart';
import 'package:travel/entity/upload_date_entity.dart';

UploadDateEntity $UploadDateEntityFromJson(Map<String, dynamic> json) {
  final UploadDateEntity uploadDateEntity = UploadDateEntity();
  final String? datejudge = jsonConvert.convert<String>(json['datejudge']);
  if (datejudge != null) {
    uploadDateEntity.datejudge = datejudge;
  }
  return uploadDateEntity;
}

Map<String, dynamic> $UploadDateEntityToJson(UploadDateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['datejudge'] = entity.datejudge;
  return data;
}

extension UploadDateEntityExtension on UploadDateEntity {
  UploadDateEntity copyWith({
    String? datejudge,
  }) {
    return UploadDateEntity()
      ..datejudge = datejudge ?? this.datejudge;
  }
}