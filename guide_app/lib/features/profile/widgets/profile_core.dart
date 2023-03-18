import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/features/profile/widgets/full_screen_error.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../cubit/profile_cubit.dart';
import '../provider/profile_provider.dart';
import 'profile_content.dart';

/// Core of  profile screen.
class ProfileCore extends StatelessWidget {
  const ProfileCore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    final profileCubit = Provider.of<ProfileCubit>(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
        listener: ((context, state) {
      if (state is ProfileErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(state.message)));
      }
    }), builder: (context, state) {
      final profileProvider = Provider.of<ProfileProvider>(context);

      if (state is ProfileLoadingState &&
          profileProvider.guideCardDtos.isEmpty) {
        return Center(
            child: CircularProgressIndicator(
          color: theme.onSurface,
        ));
      } else if (state is ProfileSuccessState) {
        // TODO maybe check page number.
        if (state.nextPage.guideCardDtos.isNotEmpty) {
          final page = state.nextPage;
          profileProvider.guideCardDtos.addAll(page.guideCardDtos);
          profileProvider.pageNum++;
          profileCubit.isLoadingPage = false;
          // If it is first page we set pagesAmount
          // because we should not upload more pages than we have.
          if (page.pageNum == 0) {
            profileProvider.pagesAmount = page.pageAmount;
          }
        }
      } else if (state is ProfileErrorState &&
          profileProvider.guideCardDtos.isEmpty) {
        return FullScreenError(
          // TODO maybe change to refresh().
          onPressed: () => profileCubit.getNextPage(0),
          message: state.message,
        );
      } else if (state is ProfileRefreshSuccessState) {
        final page = state.nextPage;
        profileProvider.reset();
        profileProvider.guideCardDtos.addAll(page.guideCardDtos);
        profileProvider.pageNum++;
        profileCubit.isLoadingPage = false;
        if (page.pageNum == 0) {
          profileProvider.pagesAmount = page.pageAmount;
        }
      }
      return ProfileContent();
    });
  }
}
