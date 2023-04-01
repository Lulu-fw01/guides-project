import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import '../../../common/repository/guide/guide_repository.dart';
import '../../guide/cubit/guide_view/guide_view_cubit.dart';
import '../../guide/screens/guide_view_screen.dart';
import '../provider/favorites_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final guideRepo = Provider.of<GuideRepository>(context, listen: false);

    return Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
      switch (favoritesProvider.favoritesScreenMode) {
        case FavoritesScreenMode.viewFavorites:
          // Show profile info and user's guides.
          // TODO Move BLOC to main core.
          // return BlocProvider(
          //     create: (context) => ProfileCubit(guideRepository: guideRepo),
          //     child: Builder(builder: (context) {
          //       // Call getNextPage only if there were no calls before.
          //       if (profileProvider.pageNum == 0 &&
          //           Provider.of<ProfileCubit>(context).state
          //               is ProfileInitialState) {
          //         Provider.of<ProfileCubit>(context).getNextPage(0);
          //       }
          //       return const ProfileCore();
          //     }));
          return Container();
        case FavoritesScreenMode.viewGuide:
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
