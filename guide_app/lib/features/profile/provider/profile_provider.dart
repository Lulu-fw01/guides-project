import 'package:flutter/widgets.dart';
import 'package:guide_app/common/dto/guide_card_dto.dart';
import 'package:guide_app/features/profile/dto/user_info_dto.dart';

/// Provider which contains data of profile screen.
class ProfileProvider extends ChangeNotifier {
  final List<GuideCardDto> guideCardDtos = [];
  int pageNum = 0;
  int pagesAmount = 0;
  UserInfoDto? userInfoDto;

  void reset() {
    guideCardDtos.clear();
    pageNum = 0;
    pagesAmount = 0;
  }

  bool isLastPage() {
    return pageNum == pagesAmount;
  }
}
