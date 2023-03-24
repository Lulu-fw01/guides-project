import 'package:flutter/widgets.dart';

class SearchProvider extends ChangeNotifier {
  SearchScreenMode _profileScreenState = SearchScreenMode.noSearch;
}

enum SearchScreenMode { noSearch, search, viewGuide }
