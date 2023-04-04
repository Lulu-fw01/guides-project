import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../bloc/search_bloc.dart';
import '../provider/search_page_provider.dart';
import 'search_input.dart';
import 'search_page_content.dart';

/// Search page of the search screen.
/// Contains a search input and search results content.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    final searchPageProvider =
        Provider.of<SearchPageProvider>(context, listen: false);
    final searchBloc = Provider.of<SearchBloc>(context, listen: false);

    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: theme.onSurface.withOpacity(0.3))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchInput(
                onTextChange: (text) {
                  if (text.isEmpty) {
                    // If search input is empty
                    // then show no search results.
                    searchPageProvider.searchFinished();
                  } else {
                    // If there were not search before
                    // then start to show search results.
                    if (!searchPageProvider.isSearching()) {
                      searchPageProvider.searchStarted();
                    }
                    // Start search event.
                    if (searchBloc.lastSearchPhrase != text) {
                      searchBloc.add(SearchGuidesByTitleEvent(
                          searchPhrase: text, pageNum: 0));
                    }
                  }
                },
              ),
            ),
          ),
          const SearchPageContent()
        ],
      ),
    );
  }
}
