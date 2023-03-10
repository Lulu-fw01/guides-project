import 'package:json_annotation/json_annotation.dart';

part 'guide_card_dto.g.dart';

/// Guide card dto.
@JsonSerializable()
class GuideCardDto {
  GuideCardDto(this.guideId, this.author, this.guideName, this.editDate);
  final int guideId;

  /// Guide author login.
  @JsonKey(name: 'creatorLogin')
  final String author;

  /// Guide name.
  @JsonKey(name: 'title')
  final String guideName;

  /// Edit date of the guide.
  final String editDate;

  factory GuideCardDto.fromJson(Map<String, dynamic> json) =>
      _$GuideCardDtoFromJson(json);
}
