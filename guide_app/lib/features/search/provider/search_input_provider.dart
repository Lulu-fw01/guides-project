import 'package:flutter/widgets.dart';

import '../bloc/search_bloc.dart';
import 'search_page_provider.dart';

class SearchInputProvider extends ChangeNotifier {
  final searchTextController = TextEditingController();

  void addSearchListener(
      SearchPageProvider searchPageProvider, SearchBloc searchBloc) {
    // searchTextController.addListener(() {
    //   if (searchTextController.text.isEmpty) {

    //   }
    // });
  }

  /// CLear search input.
  void clearSearchText() {
    searchTextController.clear();
    notifyListeners();
  }
}
