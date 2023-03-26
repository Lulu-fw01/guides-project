import 'package:flutter/widgets.dart';

class SearchProvider extends ChangeNotifier {
  SearchScreenMode _profileScreenState = SearchScreenMode.noSearch;

  SearchScreenMode get profileScreenState => _profileScreenState;

  void searchStarted() {
    _profileScreenState = SearchScreenMode.searchMode;
    notifyListeners();
  }
}

enum SearchScreenMode {
  // User just opened the search screen.
  noSearch,
  // User tapped the search button.
  searchMode,
  // User is watching guide.
  viewGuide
}
