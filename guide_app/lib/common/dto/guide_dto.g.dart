// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideDto _$GuideDtoFromJson(Map<String, dynamic> json) => GuideDto(
      json['id'] as int,
      json['creatorLogin'] as String,
      json['title'] as String,
      json['fileBytes'] as String,
      DateTime.parse(json['editDate'] as String),
      json['isBlocked'] as bool,
    );

Map<String, dynamic> _$GuideDtoToJson(GuideDto instance) => <String, dynamic>{
      'id': instance.id,
      'creatorLogin': instance.login,
      'title': instance.title,
      'fileBytes': instance.content,
      'editDate': instance.editDate.toIso8601String(),
      'isBlocked': instance.isBlocked,
    };
