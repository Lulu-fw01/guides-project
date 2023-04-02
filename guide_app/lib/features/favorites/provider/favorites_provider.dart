import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';

/// This class contains data of favorites screen.
class FavoritesProvider extends ChangeNotifier {
  List<GuideCardDto> guideCardDtos = [];

  /// Number of current page.
  int pageNum = 0;

  /// Total number of pages.
  int pagesAmount = 0;

  FavoritesScreenState favoritesScreenState =
      FavoritesScreenState.viewFavorites;

  int? viewedGuideId = null;

  /// Add guide to favorites or remove from favorites.
  void toggleFavorite(GuideCardDto guideCardDto) {
    if (guideCardDto.addedToFavorites) {
    } else {}
  }

  void reset() {
    guideCardDtos.clear();
    pageNum = 0;
    pagesAmount = 0;
  }

  void setFavoritesScreenState(FavoritesScreenState favoritesScreenMode) {
    favoritesScreenMode = favoritesScreenMode;
    notifyListeners();
  }

  /// Show chosen guide.
  /// [guideId] - id of the chosen guide.
  void showGuide(int guideId) {
    viewedGuideId = guideId;
    setFavoritesScreenState(FavoritesScreenState.viewGuide);
  }

  /// Go to profile info screen.
  void showFavorites() {
    setFavoritesScreenState(FavoritesScreenState.viewFavorites);
  }

  bool isLastPage() {
    return pageNum == pagesAmount;
  }

  void addToFavorites(GuideCardDto dto) {
    guideCardDtos.insert(0, dto);
    // TODO count inserted and removed elements.
    notifyListeners();
  }

  void removeFromFavorites(GuideCardDto dto) {
    guideCardDtos.remove(dto);
    // TODO count inserted and removed elements.
    notifyListeners();
  }
}

enum FavoritesScreenState { viewFavorites, viewGuide }
