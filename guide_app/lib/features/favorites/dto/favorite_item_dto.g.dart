// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteItemDto _$FavoriteItemDtoFromJson(Map<String, dynamic> json) =>
    FavoriteItemDto(
      json['guideId'] as int,
      json['userEmail'] as String,
    );

Map<String, dynamic> _$FavoriteItemDtoToJson(FavoriteItemDto instance) =>
    <String, dynamic>{
      'guideId': instance.guideId,
      'userEmail': instance.userEmail,
    };
