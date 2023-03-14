// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideCardDto _$GuideCardDtoFromJson(Map<String, dynamic> json) => GuideCardDto(
      json['id'] as int,
      json['creatorLogin'] as String,
      json['title'] as String,
      json['editDate'] as String,
    );

Map<String, dynamic> _$GuideCardDtoToJson(GuideCardDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorLogin': instance.author,
      'title': instance.guideName,
      'editDate': instance.editDate,
    };
