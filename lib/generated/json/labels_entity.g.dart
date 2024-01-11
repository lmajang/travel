import 'package:travel/generated/json/base/json_convert_content.dart';
import 'package:travel/entity/labels_entity.dart';

LabelsEntity $LabelsEntityFromJson(Map<String, dynamic> json) {
  final LabelsEntity labelsEntity = LabelsEntity();
  final List<LabelsLabels>? labels = (json['labels'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<LabelsLabels>(e) as LabelsLabels).toList();
  if (labels != null) {
    labelsEntity.labels = labels;
  }
  return labelsEntity;
}

Map<String, dynamic> $LabelsEntityToJson(LabelsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['labels'] = entity.labels?.map((v) => v.toJson()).toList();
  return data;
}

extension LabelsEntityExtension on LabelsEntity {
  LabelsEntity copyWith({
    List<LabelsLabels>? labels,
  }) {
    return LabelsEntity()
      ..labels = labels ?? this.labels;
  }
}

LabelsLabels $LabelsLabelsFromJson(Map<String, dynamic> json) {
  final LabelsLabels labelsLabels = LabelsLabels();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    labelsLabels.label = label;
  }
  final String? sceneryid = jsonConvert.convert<String>(json['sceneryid']);
  if (sceneryid != null) {
    labelsLabels.sceneryid = sceneryid;
  }
  return labelsLabels;
}

Map<String, dynamic> $LabelsLabelsToJson(LabelsLabels entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['sceneryid'] = entity.sceneryid;
  return data;
}

extension LabelsLabelsExtension on LabelsLabels {
  LabelsLabels copyWith({
    String? label,
    String? sceneryid,
  }) {
    return LabelsLabels()
      ..label = label ?? this.label
      ..sceneryid = sceneryid ?? this.sceneryid;
  }
}