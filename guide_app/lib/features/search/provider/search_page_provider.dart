import 'package:flutter/widgets.dart';

/// This provider work with Search page states.
class SearchPageProvider extends ChangeNotifier {
  SearchPageMode _searchPageState = SearchPageMode.noSearch;

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
}

enum SearchPageMode {
  // User just opened the search screen.
  noSearch,
  // User tapped the search button.
  searching,
}
