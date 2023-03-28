import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/guide_card.dart';
import '../bloc/search_bloc.dart';
import '../provider/search_page_provider.dart';
import '../provider/search_screen_provider.dart';

class SearchResults extends StatelessWidget {
  SearchResults({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    final searchScreenProvider =
        Provider.of<SearchScreenProvider>(context, listen: false);
    final searchPageProvider =
        Provider.of<SearchPageProvider>(context, listen: false);
    final theme = Provider.of<MainTheme>(context);

    List<Widget> list = [];
    list.addAll(searchPageProvider.guideCardDtos
        .map(
          (dto) => GuideCard(
            dto,
            onClick: () {
              // TODO searchScreenProvider.showGuide(dto.id);
              // profileProvider.showGuide(dto.id);
            },
          ),
        )
        .toList());
    list.add(_loadingProgress(theme));

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      key: const PageStorageKey('search_page_cards'),
      controller: _scrollController
        ..addListener(() {
          // If we at the end of the list we will upload
          // next page if it is not last.
          if (_scrollController.offset ==
                  _scrollController.position.maxScrollExtent &&
              !searchBloc.isLoadingPage &&
              !searchPageProvider.isLastPage()) {
            searchBloc.isLoadingPage = true;
            // Load next page.
            searchBloc.add(SearchGuidesByTitleEvent(
                searchPhrase: searchPageProvider.searchPhrase,
                pageNum: searchPageProvider.pageNum));
          }
        }),
      children: list,
    );
  }

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
