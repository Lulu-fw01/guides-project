import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/full_screen_error.dart';
import '../bloc/search_bloc.dart';
import '../provider/search_page_provider.dart';
import 'search_results.dart';

/// Core of search results.
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
      final searchPageProvider =
          Provider.of<SearchPageProvider>(context, listen: false);

      if (state is SearchLoadingState &&
          searchPageProvider.guideCardDtos.isEmpty) {
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
            searchPageProvider.guideCardDtos.clear();
            searchPageProvider.guideCardDtos.addAll(page.guideCardDtos);
            searchPageProvider.pageNum = 1;
            searchPageProvider.pagesAmount = page.pageAmount;
            searchPageProvider.searchPhrase = state.searchPhrase;
          } else {
            // Continue showing guides.
            searchPageProvider.guideCardDtos.addAll(page.guideCardDtos);
            searchPageProvider.pageNum++;
          }
          searchBloc.isLoadingPage = false;
        }
      } else if (state is SearchErrorState &&
          searchPageProvider.guideCardDtos.isEmpty) {
        return FullScreenError(
          onPressed: () => {} /*profileCubit.getNextPage(0)*/,
          message: state.message,
        );
      }
      return SearchResults();
    });
  }
}
