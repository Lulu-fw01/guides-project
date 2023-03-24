import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/repository/guide/guide_repository.dart';
import '../../guide/cubit/guide_view/guide_view_cubit.dart';
import '../../guide/screens/guide_view_screen.dart';
import '../cubit/profile_cubit.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_core.dart';

/// Profile screen.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guideRepo = Provider.of<GuideRepository>(context, listen: false);

    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      switch (profileProvider.profileScreenState) {
        case ProfileScreenMode.profileInfo:
          // Show profile info and user's guides.
          // TODO Move BLOC to main core.
          return BlocProvider(
              create: (context) => ProfileCubit(guideRepository: guideRepo),
              child: Builder(builder: (context) {
                // Call getNextPage only if there were no calls before.
                if (profileProvider.pageNum == 0 &&
                    Provider.of<ProfileCubit>(context).state
                        is ProfileInitialState) {
                  Provider.of<ProfileCubit>(context).getNextPage(0);
                }
                return const ProfileCore();
              }));
        case ProfileScreenMode.viewGuide:
          // Show chosen guide from profile screen.
          // TODO Move BLOC to main core.
          return BlocProvider(
              create: (context) => GuideViewCubit(guideRepository: guideRepo),
              child: Builder(
                builder: (context) {
                  if (profileProvider.viewedGuideId != null) {
                    // TODO fix: if guide have been already loaded we should not reload it again.
                    Provider.of<GuideViewCubit>(context, listen: false)
                        .showGuide(profileProvider.viewedGuideId!);
                    return const GuideViewScreen();
                  }
                  return Container();
                },
              ));
      }
    });
  }
}
