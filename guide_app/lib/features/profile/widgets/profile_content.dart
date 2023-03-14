import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/dto/guide_card_dto.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/common/widgets/guide_card.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:provider/provider.dart';

class ProfileContent extends StatelessWidget {
  ProfileContent({super.key});

  // Move to provider
  final List<GuideCardDto> guideCardDtos = [];
  int pageNum = 0;
  final ScrollController _scrollController = ScrollController();

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
      // if (state is ProfileInitialState) {
      //   profileCubit.getNextPage(pageNum);
      // }
      if (state is ProfileInitialState ||
          state is ProfileLoadingState && guideCardDtos.isEmpty) {
        return Center(
            child: CircularProgressIndicator(
          color: theme.onSurface,
        ));
      } else if (state is ProfileSuccessState) {
        guideCardDtos.addAll(state.guideCards);
        pageNum++;
      } else if (state is ProfileErrorState && guideCardDtos.isEmpty) {
        return _buildErrorWithEmptyCards(profileCubit, theme, state);
      }
      return _buildListOfCards(profileCubit, theme);
    });
  }

  Widget _buildListOfCards(ProfileCubit profileCubit, MainTheme theme) {
    return ListView.separated(
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.offset ==
                _scrollController.position.maxScrollExtent) {
              profileCubit.getNextPage(pageNum);
            }
          }),
        itemBuilder: (BuildContext context, int index) =>
            GuideCard(guideCardDtos[index]),
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 3,
              color: theme.onSurface,
            ),
        itemCount: guideCardDtos.length);
  }

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
