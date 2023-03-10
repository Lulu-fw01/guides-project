// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_guide_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGuidePageDto _$UserGuidePageDtoFromJson(Map<String, dynamic> json) =>
    UserGuidePageDto(
      json['email'] as String,
      json['pageNumber'] as int,
      json['pageSize'] as int,
    );

Map<String, dynamic> _$UserGuidePageDtoToJson(UserGuidePageDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
