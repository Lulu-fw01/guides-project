import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';
import '../dto/user_info_dto.dart';

/// Provider which contains data of profile screen.
class ProfileProvider extends ChangeNotifier {
  final List<GuideCardDto> guideCardDtos = [];

  /// Number of current page.
  int pageNum = 0;

  /// Total number of pages.
  int pagesAmount = 0;
  UserInfoDto? userInfoDto;

  ProfileScreenMode _profileScreenState = ProfileScreenMode.profileInfo;

  /// Id of the guide user currently viewing.
  int? viewedGuideId;

  ProfileScreenMode get profileScreenState => _profileScreenState;
  void setProfileScreenState(ProfileScreenMode profileScreenState) {
    _profileScreenState = profileScreenState;
    notifyListeners();
  }

  /// Show chosen guide.
  /// [guideId] - id of the chosen guide.
  void showGuide(int guideId) {
    viewedGuideId = guideId;
    setProfileScreenState(ProfileScreenMode.viewGuide);
  }

  /// Go to profile info screen.
  void showProfileInfo() {
    setProfileScreenState(ProfileScreenMode.profileInfo);
  }

  void reset() {
    guideCardDtos.clear();
    pageNum = 0;
    pagesAmount = 0;
  }

  bool isLastPage() {
    return pageNum == pagesAmount;
  }

  /// Try to find special guide
  /// card and change it favorites state.
  void toggleFavorites(GuideCardDto dto) {
    try {
      guideCardDtos.firstWhere((element) => element == dto).addedToFavorites =
          dto.addedToFavorites;
      notifyListeners();
    } catch (e) {}
  }
}

enum ProfileScreenMode { profileInfo, viewGuide }
