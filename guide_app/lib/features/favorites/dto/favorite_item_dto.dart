import 'package:json_annotation/json_annotation.dart';

part 'favorite_item_dto.g.dart';

/// Dto for adding or removing guide from favorites.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class FavoriteItemDto {
  FavoriteItemDto(this.guideId, this.userEmail);
  final int guideId;
  final String userEmail;

  Map<String, dynamic> toJson() => _$FavoriteItemDtoToJson(this);
}
