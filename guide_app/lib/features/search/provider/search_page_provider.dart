import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';

/// This provider work with Search page provider data.
class SearchPageProvider extends ChangeNotifier {
  SearchPageMode _searchPageState = SearchPageMode.noSearch;

  final List<GuideCardDto> guideCardDtos = [];

  /// Number of current page.
  int pageNum = 0;

  /// Total number of pages.
  int pagesAmount = 0;

  /// Current search phrase.
  String searchPhrase = '';

  SearchPageMode get searchPageState => _searchPageState;

  bool isSearching() {
    return _searchPageState == SearchPageMode.searching;
  }

  late int _viewedGuideId;
  set viewedGuideId(int value) {
    _viewedGuideId = value;
  }

  int get viewedGuideId => _viewedGuideId;

  void searchStarted() {
    _searchPageState = SearchPageMode.searching;
    notifyListeners();
  }

  void searchFinished() {
    _searchPageState = SearchPageMode.noSearch;
    notifyListeners();
  }

  bool isLastPage() {
    return pageNum == pagesAmount;
  }

  /// Try to find special guide
  /// card and change it favorites state.
  void toggleFavorites(GuideCardDto dto) {
    guideCardDtos.firstWhere((element) => element == dto).addedToFavorites =
        dto.addedToFavorites;
    notifyListeners();
  }
}

enum SearchPageMode {
  // User just opened the search screen.
  noSearch,
  // User tapped the search button.
  searching,
}
