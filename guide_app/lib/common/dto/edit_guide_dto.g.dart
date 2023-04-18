// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_guide_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditGuideDto _$EditGuideDtoFromJson(Map<String, dynamic> json) => EditGuideDto(
      json['id'] as int,
      json['title'] as String,
      json['contents'] as String,
    );

Map<String, dynamic> _$EditGuideDtoToJson(EditGuideDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.content,
    };
