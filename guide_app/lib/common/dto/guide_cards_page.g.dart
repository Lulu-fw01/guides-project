// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_cards_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideCardsPage _$GuideCardsPageFromJson(Map<String, dynamic> json) =>
    GuideCardsPage(
      json['currentPageNumber'] as int,
      json['pageAmount'] as int,
      (json['guideInfoDTOS'] as List<dynamic>)
          .map((e) => GuideCardDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuideCardsPageToJson(GuideCardsPage instance) =>
    <String, dynamic>{
      'currentPageNumber': instance.pageNum,
      'pageAmount': instance.pageAmount,
      'guideInfoDTOS': instance.guideCardDtos,
    };
