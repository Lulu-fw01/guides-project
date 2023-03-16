import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/common/widgets/guide_card.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:guide_app/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

/// Part of [ProfileContent] where we draw guide cards.
class CardsList extends StatelessWidget {
  CardsList({super.key});

  final ScrollController _scrollController = ScrollController();

  Future<void> onRefresh(
      ProfileProvider profileProvider, ProfileCubit profileCubit) async {
    profileProvider.reset();
    profileCubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = Provider.of<ProfileCubit>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final theme = Provider.of<MainTheme>(context);
    final totalLength = profileProvider.guideCardDtos.length + 1;
    return RefreshIndicator(
      color: theme.onSurface,
      onRefresh: () => onRefresh(profileProvider, profileCubit),
      child: ListView.separated(
          key: const PageStorageKey('profile_page_cards'),
          controller: _scrollController
            ..addListener(() {
              // TODO check last page.
              if (_scrollController.offset ==
                      _scrollController.position.maxScrollExtent &&
                  !profileCubit.isLoadingPage) {
                profileCubit.isLoadingPage = true;
                profileCubit.getNextPage(profileProvider.pageNum);
              }
            }),
          itemBuilder: (BuildContext context, int index) {
            if (index == totalLength - 1) {
              return BlocSelector<ProfileCubit, ProfileState, bool>(
                  selector: (state) => state is ProfileLoadingState,
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
            return GuideCard(profileProvider.guideCardDtos[index]);
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: 3,
                color: theme.onSurface,
              ),
          itemCount: totalLength),
    );
  }
}
