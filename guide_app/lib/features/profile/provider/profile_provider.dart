import 'package:flutter/widgets.dart';
import 'package:guide_app/common/dto/guide_card_dto.dart';

/// Provider which contains data of profile screen.
class ProfileProvider extends ChangeNotifier {
  final List<GuideCardDto> guideCardDtos = [];
  int pageNum = 0;
}