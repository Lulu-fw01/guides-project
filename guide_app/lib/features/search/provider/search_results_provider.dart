import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';

/// Provider which works with search results data.
class SearchResultsProvider extends ChangeNotifier {
  final List<GuideCardDto> guideCardDtos = [];

  /// Number of current page.
  int pageNum = 0;

  /// Total number of pages.
  int pagesAmount = 0;

  /// Current search phrase.
  String searchPhrase = '';

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
