import 'package:flutter/widgets.dart';

/// SearchScreenProvider controls the search screen state (search mode view guide mode).
class SearchScreenProvider extends ChangeNotifier {
  SearchScreenMode _profileScreenState = SearchScreenMode.searchMode;

  SearchScreenMode get profileScreenState => _profileScreenState;

  late int _viewedGuideId;
  set viewedGuideId(int value) {
    _viewedGuideId = value;
  }

  int get viewedGuideId => _viewedGuideId;
}

enum SearchScreenMode {
  /// User is searching.
  searchMode,

  /// User is watching guide chosen from search results.
  guideViewMode
}
