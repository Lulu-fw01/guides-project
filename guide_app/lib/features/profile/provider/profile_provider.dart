import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';
import '../dto/user_info_dto.dart';

/// Provider which contains data of profile screen.
class ProfileProvider extends ChangeNotifier {
  final List<GuideCardDto> guideCardDtos = [];
  int pageNum = 0;
  int pagesAmount = 0;
  UserInfoDto? userInfoDto;

  ProfileScreenMode _profileScreenState = ProfileScreenMode.profileInfo;

  int? viewedGuideId;

  ProfileScreenMode get profileScreenState => _profileScreenState;
  void setProfileScreenState(ProfileScreenMode profileScreenState) {
    _profileScreenState = profileScreenState;
    notifyListeners();
  }

  void showGuide(int guideId) {
    viewedGuideId = guideId;
    setProfileScreenState(ProfileScreenMode.viewGuide);
  }

  void reset() {
    guideCardDtos.clear();
    pageNum = 0;
    pagesAmount = 0;
  }

  bool isLastPage() {
    return pageNum == pagesAmount;
  }
}

enum ProfileScreenMode { profileInfo, viewGuide }
