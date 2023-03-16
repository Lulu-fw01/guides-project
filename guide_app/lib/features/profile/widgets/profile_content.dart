import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:guide_app/features/profile/provider/profile_provider.dart';
import 'package:guide_app/features/profile/widgets/cards_list.dart';
import 'package:provider/provider.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

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
          profileProvider.guideCardDtos.addAll(state.nextPage.guideCardDtos);
          profileProvider.pageNum++;
          profileCubit.isLoadingPage = false;
        }
      } else if (state is ProfileErrorState &&
          profileProvider.guideCardDtos.isEmpty) {
        return _buildErrorWithEmptyCards(profileCubit, theme, state);
      }
      return CardsList();
    });
  }

  // TODO move to different widget.
  Widget _buildErrorWithEmptyCards(ProfileCubit profileCubit, MainTheme theme,
      ProfileErrorState errorState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            profileCubit.getNextPage(0);
          },
          icon: const Icon(Icons.refresh),
        ),
        const SizedBox(height: 15),
        Text(errorState.message, textAlign: TextAlign.center),
      ],
    );
  }
}
