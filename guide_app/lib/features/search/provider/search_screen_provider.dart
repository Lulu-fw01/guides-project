import 'package:flutter/widgets.dart';

/// SearchScreenProvider controls the search screen state (search mode view guide mode).
class SearchScreenProvider extends ChangeNotifier {
  SearchScreenMode _searchScreenState = SearchScreenMode.searchMode;

  SearchScreenMode get profileScreenState => _searchScreenState;

  late int _viewedGuideId;
  set viewedGuideId(int value) {
    _viewedGuideId = value;
  }

  /// Id of chosen guide.
  int get viewedGuideId => _viewedGuideId;

  void setProfileScreenState(SearchScreenMode profileScreenState) {
    _searchScreenState = profileScreenState;
    notifyListeners();
  }

  /// Show chosen guide.
  /// [guideId] - id of the chosen guide.
  void showGuide(int guideId) {
    viewedGuideId = guideId;
    setProfileScreenState(SearchScreenMode.guideViewMode);
  }

  /// Go to search mode.
  void showSearch() {
    setProfileScreenState(SearchScreenMode.searchMode);
  }
}

enum SearchScreenMode {
  /// User is searching.
  searchMode,

  /// User is watching guide chosen from search results.
  guideViewMode
}
