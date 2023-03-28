import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/search_page_provider.dart';
import 'search_results_core.dart';

/// Search content.
class SearchPageContent extends StatelessWidget {
  const SearchPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchPageProvider>(
      builder: (context, provider, child) {
        switch (provider.searchPageState) {
          case SearchPageMode.noSearch:
            // TODO add something later.
            return Container();
          case SearchPageMode.searching:
            // Guide cards.
            return const SearchResultsCore();
        }
      },
    );
  }
}
