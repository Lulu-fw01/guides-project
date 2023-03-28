import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/search_page_provider.dart';
import 'search_input.dart';
import 'search_page_content.dart';

/// Search page of the search screen.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider =
        Provider.of<SearchPageProvider>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchInput(onTextChanged: (text) {
              if (text.isEmpty) {
                searchProvider.searchFinished();
              } else {
                searchProvider.searchStarted();
                // Provider.of<SearchBloc>(context, listen: false)
                //     .add(SearchGuidesByTitleEvent(searchPhrase: text, pageNum: 0));
              }
            }),
            const SearchPageContent()
          ],
        ),
      ),
    );
  }
}
