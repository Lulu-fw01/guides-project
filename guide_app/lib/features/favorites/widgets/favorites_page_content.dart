import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/guide_card.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_page_cubit.dart';
import '../provider/favorites_provider.dart';

/// Display cards that were added to favorites.
class FavoritesPageContent extends StatelessWidget {
  FavoritesPageContent({super.key});

  final ScrollController _scrollController = ScrollController();

  Future<void> onRefresh(FavoritesPageCubit favoritesPageCubit) async {
    favoritesPageCubit.isLoadingPage = true;
    await favoritesPageCubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesPageCubit =
        Provider.of<FavoritesPageCubit>(context, listen: false);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final theme = Provider.of<MainTheme>(context);
    final favoritesCubit = Provider.of<FavoritesCubit>(context, listen: false);

    List<Widget> list = [];
    list.add(_loadingRefreshProgress(theme));
    list.addAll(favoritesProvider.guideCardDtos
        .map(
          (dto) => GuideCard(
            dto,
            onClick: () {
              favoritesProvider.showGuide(dto.id);
            },
            onFavoritesButtonClick: () {
              favoritesCubit.toggleFavorite(dto);
            },
          ),
        )
        .toList());
    list.add(_loadingProgress(theme));

    //
    // return RefreshIndicator(
    //     color: theme.onSurface,
    //     onRefresh: () => onRefresh(favoritesPageCubit),
    //     child: ListView.bui(
    //       physics: const AlwaysScrollableScrollPhysics(),
    //       key: const PageStorageKey('favorites_page_cards'),
    //       controller: _scrollController
    //         ..addListener(() {
    //           // If we at the end of the list we will upload
    //           // next page if it is not last.
    //           if (_scrollController.offset ==
    //                   _scrollController.position.maxScrollExtent &&
    //               !favoritesPageCubit.isLoadingPage &&
    //               !favoritesProvider.isLastPage()) {
    //             favoritesPageCubit.isLoadingPage = true;
    //             favoritesPageCubit.getNextPage(favoritesProvider.pageNum);
    //           }
    //         }),
    //       children: list,
    //     ));

    return RefreshIndicator(
        color: theme.onSurface,
        onRefresh: () => onRefresh(favoritesPageCubit),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          key: const PageStorageKey('favorites_page_cards'),
          controller: _scrollController
            ..addListener(() {
              // If we at the end of the list we will upload
              // next page if it is not last.
              if (_scrollController.offset ==
                      _scrollController.position.maxScrollExtent &&
                  !favoritesPageCubit.isLoadingPage &&
                  !favoritesProvider.isLastPage()) {
                favoritesPageCubit.isLoadingPage = true;
                favoritesPageCubit.getNextPage(favoritesProvider.pageNum);
              }
            }),
          itemCount: list.length,
          itemBuilder: (context, index) => list[index],
        ));
  }

  Widget _loadingProgress(MainTheme theme) {
    return BlocSelector<FavoritesPageCubit, FavoritesPageState, bool>(
        selector: (state) => state is LoadingFavoritesPageState,
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

  Widget _loadingRefreshProgress(MainTheme theme) {
    return BlocSelector<FavoritesPageCubit, FavoritesPageState, bool>(
        selector: (state) => state is RefreshLoadingFavoritesPageState,
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
