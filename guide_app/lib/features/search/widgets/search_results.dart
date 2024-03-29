import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/cubit/guide_utils_cubit.dart';
import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/guide_card.dart';
import '../../../common/widgets/user_credentials.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../../main_core/provider/core_provider.dart';
import '../bloc/search_bloc.dart';
import '../provider/search_page_provider.dart';
import '../provider/search_results_provider.dart';
import '../provider/search_screen_provider.dart';

/// Widget which show guide cards from search results.
class SearchResults extends StatelessWidget {
  SearchResults({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final searchScreenProvider =
        Provider.of<SearchScreenProvider>(context, listen: false);
    final searchPageProvider =
        Provider.of<SearchPageProvider>(context, listen: false);
    final searchResultsProvider = Provider.of<SearchResultsProvider>(context);
    final guideUtilsCubit =
        Provider.of<GuideUtilsCubit>(context, listen: false);
    final credentials = UserCredentials.of(context);
    final theme = Provider.of<MainTheme>(context);
    final favoritesCubit = Provider.of<FavoritesCubit>(context, listen: false);

    List<Widget> list = [];
    // Guide cards.
    list.addAll(searchResultsProvider.guideCardDtos
        .map(
          (dto) => GuideCard(
            dto,
            onClick: () {
              searchScreenProvider.showGuide(dto.id);
            },
            onFavoritesButtonClick: () {
              favoritesCubit.toggleFavorite(dto);
            },
            onRemove: dto.author == credentials.userLogin
                ? () {
                    guideUtilsCubit.removeGuide(dto.id);
                  }
                : null,
            onEdit: dto.author == credentials.userLogin
                ? () {
                    Provider.of<CoreProvider>(context, listen: false)
                        .updateGuide(dto.id);
                  }
                : null,
          ),
        )
        .toList());
    // Loading progress circle while loading next page.
    list.add(_loadingProgress(theme));

    return Expanded(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        key: const PageStorageKey('search_page_cards'),
        controller: _scrollController
          ..addListener(() {
            // If we at the end of the list we will upload
            // next page if it is not last.
            if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent &&
                !searchBloc.isLoadingPage &&
                !searchResultsProvider.isLastPage()) {
              searchBloc.isLoadingPage = true;
              // Load next page.
              searchBloc.add(SearchGuidesByTitleEvent(
                  searchPhrase: searchResultsProvider.searchPhrase,
                  pageNum: searchResultsProvider.pageNum));
            }
          }),
        children: list,
      ),
    );
  }

  /// TODO move to common later.
  Widget _loadingProgress(MainTheme theme) {
    return BlocSelector<SearchBloc, SearchState, bool>(
        selector: (state) => state is SearchLoadingState,
        builder: (context, isLoading) => isLoading
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: CircularProgressIndicator(
                    color: theme.onSurface,
                  ),
                ),
              )
            : Container());
  }
}
