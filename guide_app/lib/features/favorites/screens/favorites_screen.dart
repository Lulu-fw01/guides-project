import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/favorites_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    //final guideRepo = Provider.of<GuideRepository>(context, listen: false);

    return Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
      // switch (profileProvider.profileScreenState) {
      //   case ProfileScreenMode.profileInfo:
      //     // Show profile info and user's guides.
      //     // TODO Move BLOC to main core.
      //     return BlocProvider(
      //         create: (context) => ProfileCubit(guideRepository: guideRepo),
      //         child: Builder(builder: (context) {
      //           // Call getNextPage only if there were no calls before.
      //           if (profileProvider.pageNum == 0 &&
      //               Provider.of<ProfileCubit>(context).state
      //                   is ProfileInitialState) {
      //             Provider.of<ProfileCubit>(context).getNextPage(0);
      //           }
      //           return const ProfileCore();
      //         }));
      //   case ProfileScreenMode.viewGuide:
      //     // Show chosen guide from profile screen.
      //     // TODO Move BLOC somewhere.
      //     // Нельзя перенести блок в main, но можно попробовать в провайдер.
      //     return BlocProvider(
      //         create: (context) => GuideViewCubit(guideRepository: guideRepo),
      //         child: Builder(
      //           builder: (context) {
      //             if (profileProvider.viewedGuideId != null) {
      //               // TODO fix: if guide have been already loaded we should not reload it again.
      //               Provider.of<GuideViewCubit>(context, listen: false)
      //                   .showGuide(profileProvider.viewedGuideId!);
      //               return const GuideViewScreen();
      //             }
      //             return Container();
      //           },
      //         ));
      // }
      return Container();
    });
  }
}
