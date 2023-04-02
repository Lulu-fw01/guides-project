import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/full_screen_error.dart';
import '../cubit/favorites_page_cubit.dart';
import '../provider/favorites_provider.dart';
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
      final favoritesProvider =
          Provider.of<FavoritesProvider>(context, listen: false);
      final favoritesPageCubit =
          Provider.of<FavoritesPageCubit>(context, listen: false);

      if (state is LoadingFavoritesPageState &&
          favoritesProvider.guideCardDtos.isEmpty) {
        return Center(
            child: CircularProgressIndicator(
          color: theme.onSurface,
        ));
      } else if (state is SuccessFavoritesPageState) {
        // TODO maybe check page number.
        if (state.nextPage.guideCardDtos.isNotEmpty) {
          final page = state.nextPage;
          favoritesProvider.guideCardDtos.addAll(page.guideCardDtos);
          favoritesProvider.pageNum++;
          favoritesPageCubit.isLoadingPage = false;
          // If it is first page we set pagesAmount
          // because we should not upload more pages than we have.
          if (page.pageNum == 0) {
            favoritesProvider.pagesAmount = page.pageAmount;
          }
        }
      } else if (state is ErrorFavoritesPageState &&
          favoritesProvider.guideCardDtos.isEmpty) {
        return FullScreenError(
          // TODO maybe change to refresh().
          onPressed: () => favoritesPageCubit.getNextPage(0),
          message: state.errorMessage,
        );
      } else if (state is RefreshSuccessFavoritesPageState) {
        final page = state.nextPage;
        favoritesProvider.reset();
        favoritesProvider.guideCardDtos.addAll(page.guideCardDtos);
        favoritesProvider.pageNum++;
        favoritesPageCubit.isLoadingPage = false;
        if (page.pageNum == 0) {
          favoritesProvider.pagesAmount = page.pageAmount;
        }
      }
      return FavoritesPageContent();
    });
  }
}
