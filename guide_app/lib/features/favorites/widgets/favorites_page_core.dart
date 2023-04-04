import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/full_screen_error.dart';
import '../cubit/favorites_page_cubit.dart';
import '../provider/favorites_content_provider.dart';
import 'favorites_page_content.dart';

/// Class which contains BlocConsumer for controlling loading favorites page.
class FavoritesPageCore extends StatelessWidget {
  const FavoritesPageCore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);

    return BlocConsumer<FavoritesPageCubit, FavoritesPageState>(
        listener: ((context, state) {
      // Error with loading favorites page.
      if (state is ErrorFavoritesPageState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(state.errorMessage)));
      }
    }), builder: (context, state) {
      final favoritesContentProvider =
          Provider.of<FavoritesContentProvider>(context, listen: false);
      final favoritesPageCubit =
          Provider.of<FavoritesPageCubit>(context, listen: false);

      if (state is LoadingFavoritesPageState &&
          favoritesContentProvider.guideCardDtos.isEmpty) {
        return Center(
            child: CircularProgressIndicator(
          color: theme.onSurface,
        ));
      } else if (state is SuccessFavoritesPageState &&
          favoritesPageCubit.isLoadingPage) {
        // We should not get values from here every build.
        // Add card only if they were already loaded.
        if (state.nextPage.guideCardDtos.isNotEmpty) {
          final page = state.nextPage;
          favoritesContentProvider.guideCardDtos.addAll(page.guideCardDtos);
          favoritesContentProvider.pageNum++;
          favoritesPageCubit.isLoadingPage = false;
          // If it is first page we set pagesAmount
          // because we should not upload more pages than we have.
          if (page.pageNum == 0) {
            favoritesContentProvider.pagesAmount = page.pageAmount;
          }
        }
      } else if (state is ErrorFavoritesPageState &&
          favoritesContentProvider.guideCardDtos.isEmpty) {
        return FullScreenError(
          // TODO maybe change to refresh().
          onPressed: () => favoritesPageCubit.getNextPage(-1),
          message: state.errorMessage,
        );
      } else if (state is RefreshSuccessFavoritesPageState &&
          favoritesPageCubit.isLoadingPage) {
        // We should not get values from here every build.
        // Add card only if they were already loaded.
        final page = state.nextPage;
        favoritesContentProvider.reset();
        favoritesContentProvider.guideCardDtos.addAll(page.guideCardDtos);
        favoritesContentProvider.pageNum++;
        favoritesPageCubit.isLoadingPage = false;
        favoritesContentProvider.pagesAmount = page.pageAmount;
      }
      return FavoritesPageContent();
    });
  }
}
