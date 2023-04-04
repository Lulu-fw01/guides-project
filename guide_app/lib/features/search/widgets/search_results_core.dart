import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/full_screen_error.dart';
import '../bloc/search_bloc.dart';
import '../provider/search_results_provider.dart';
import 'search_results.dart';

/// Core of search results.
/// This core contains BLoC consumer for controlling search content states.
class SearchResultsCore extends StatelessWidget {
  const SearchResultsCore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);

    return BlocConsumer<SearchBloc, SearchState>(listener: ((context, state) {
      if (state is SearchErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(state.message)));
      }
    }), builder: (context, state) {
      final searchResultsProvider =
          Provider.of<SearchResultsProvider>(context, listen: false);

      if (state is SearchLoadingState &&
          searchResultsProvider.guideCardDtos.isEmpty) {
        return Center(
            child: CircularProgressIndicator(
          color: theme.onSurface,
        ));
      } else if (state is SearchByTitleSuccessState) {
        final searchBloc = Provider.of<SearchBloc>(context, listen: false);
        // TODO maybe check page number.
        if (state.nextPage.guideCardDtos.isNotEmpty) {
          final page = state.nextPage;
          if (page.pageNum == 0) {
            // New search request result.
            // Clear previous search result and set new.
            searchResultsProvider.guideCardDtos.clear();
            searchResultsProvider.guideCardDtos.addAll(page.guideCardDtos);
            searchResultsProvider.pageNum = 1;
            searchResultsProvider.pagesAmount = page.pageAmount;
            searchResultsProvider.searchPhrase = state.searchPhrase;
          } else {
            // Continue showing guides.
            searchResultsProvider.guideCardDtos.addAll(page.guideCardDtos);
            searchResultsProvider.pageNum++;
          }
          searchBloc.isLoadingPage = false;
        }
      } else if (state is SearchErrorState &&
          searchResultsProvider.guideCardDtos.isEmpty) {
        return FullScreenError(
          onPressed: () => {} /*profileCubit.getNextPage(0)*/,
          message: state.message,
        );
      }
      return SearchResults();
    });
  }
}
