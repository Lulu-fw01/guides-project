import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import '../../../common/repository/guide/guide_repository.dart';
import '../../guide/cubit/guide_view/guide_view_cubit.dart';
import '../../guide/screens/guide_view_screen.dart';
import '../cubit/favorites_page_cubit.dart';
import '../provider/favorites_provider.dart';
import '../widgets/favorites_page_core.dart';

/// Screen with guides added to favorites.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guideRepo = Provider.of<GuideRepository>(context, listen: false);

    return Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
      switch (favoritesProvider.favoritesScreenState) {
        case FavoritesScreenState.viewFavorites:
          // Loading first page if it was not loaded before.
          if (Provider.of<FavoritesPageCubit>(context, listen: false).state
              is FavoritesPageInitial) {
            final favoritesPageCubit =
                Provider.of<FavoritesPageCubit>(context, listen: false);
            favoritesPageCubit.isLoadingPage = true;
            favoritesPageCubit.getNextPage(-1);
          }
          return const FavoritesPageCore();
        case FavoritesScreenState.viewGuide:
          // Show chosen guide from profile screen.
          // TODO Move BLOC somewhere.
          // Нельзя перенести блок в main, но можно попробовать в провайдер.
          return BlocProvider(
              create: (context) => GuideViewCubit(guideRepository: guideRepo),
              child: Builder(
                builder: (context) {
                  if (favoritesProvider.viewedGuideId != null) {
                    // TODO fix: if guide have been already loaded we should not reload it again.
                    Provider.of<GuideViewCubit>(context, listen: false)
                        .showGuide(favoritesProvider.viewedGuideId!);
                    return const GuideViewScreen();
                  }
                  return Container();
                },
              ));
      }
    });
  }
}
