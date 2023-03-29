import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';

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
}

enum SearchPageMode {
  // User just opened the search screen.
  noSearch,
  // User tapped the search button.
  searching,
}
