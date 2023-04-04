import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';

/// Provider which controls content of favorites page.
class FavoritesContentProvider extends ChangeNotifier {
  List<GuideCardDto> guideCardDtos = [];

  /// Number of current page.
  int pageNum = 0;

  /// Total number of pages.
  int pagesAmount = 0;

  void reset() {
    guideCardDtos.clear();
    pageNum = 0;
    pagesAmount = 0;
  }

  bool isLastPage() {
    return pageNum == pagesAmount;
  }

  /// Add guide to favorites.
  void addToFavorites(GuideCardDto dto) {
    guideCardDtos.insert(0, dto);
    notifyListeners();
  }

  /// Remove guide from favorites.
  void removeFromFavorites(GuideCardDto dto) {
    guideCardDtos.removeWhere((element) => element == dto);
    notifyListeners();
  }
}
