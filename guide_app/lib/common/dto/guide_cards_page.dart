import 'package:json_annotation/json_annotation.dart';

import 'guide_card_dto.dart';

part 'guide_cards_page.g.dart';

/// Dto with page content and info.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class GuideCardsPage {
  GuideCardsPage(this.pageNum, this.pageAmount, this.guideCardDtos);
  @JsonKey(name: "currentPageNumber")
  final int pageNum;
  final int pageAmount;
  @JsonKey(name: "guideInfoDTOS")
  final List<GuideCardDto> guideCardDtos;

  factory GuideCardsPage.fromJson(Map<String, dynamic> json) => _$GuideCardsPageFromJson(json);
}
