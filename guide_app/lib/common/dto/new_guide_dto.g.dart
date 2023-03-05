// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_guide_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewGuideDto _$NewGuideDtoFromJson(Map<String, dynamic> json) => NewGuideDto(
      json['creatorEmail'] as String,
      json['title'] as String,
      json['fileBytes'] as String,
    );

Map<String, dynamic> _$NewGuideDtoToJson(NewGuideDto instance) =>
    <String, dynamic>{
      'creatorEmail': instance.email,
      'title': instance.title,
      'fileBytes': instance.content,
    };
