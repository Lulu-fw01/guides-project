import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import '../../../common/cubit/guide_utils_cubit.dart';
import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/guide_card.dart';
import '../../../common/widgets/user_credentials.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../../main_core/provider/core_provider.dart';
import '../cubit/profile_cubit.dart';
import '../provider/profile_provider.dart';
import 'user_info.dart';

/// Part of [ProfileContent] where we draw guide cards.
class ProfileContent extends StatelessWidget {
  ProfileContent({super.key});

  final ScrollController _scrollController = ScrollController();

  Future<void> onRefresh(
      ProfileProvider profileProvider, ProfileCubit profileCubit) async {
    profileCubit.isLoadingPage = true;
    await profileCubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = Provider.of<ProfileCubit>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final theme = Provider.of<MainTheme>(context);
    final guideUtilsCubit =
        Provider.of<GuideUtilsCubit>(context, listen: false);
    final credentials = UserCredentials.of(context);
    final favoritesCubit = Provider.of<FavoritesCubit>(context, listen: false);

    List<Widget> list = [];
    list.add(_loadingRefreshProgress(theme));
    if (profileProvider.userInfoDto != null) {
      list.add(UserInfo(
        userInfoDto: profileProvider.userInfoDto!,
      ));
    }
    list.addAll(profileProvider.guideCardDtos
        .map(
          (dto) => GuideCard(
            dto,
            onClick: () {
              profileProvider.showGuide(dto.id);
            },
            onFavoritesButtonClick: () {
              favoritesCubit.toggleFavorite(dto);
            },
            onRemove: dto.author == credentials.userLogin
                ? () {
                    guideUtilsCubit.removeGuide(dto.id);
                  }
                : null,
            onEdit: dto.author == credentials.userLogin
                ? () {
                    Provider.of<CoreProvider>(context, listen: false)
                        .updateGuide(dto.id);
                  }
                : null,
          ),
        )
        .toList());
    list.add(_loadingProgress(theme));

    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(width: 1, color: theme.onSurface.withOpacity(0.4))),
      ),
      child: RefreshIndicator(
          color: theme.onSurface,
          onRefresh: () => onRefresh(profileProvider, profileCubit),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            key: const PageStorageKey('profile_page_cards'),
            controller: _scrollController
              ..addListener(() {
                // If we at the end of the list we will upload
                // next page if it is not last.
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !profileCubit.isLoadingPage &&
                    !profileProvider.isLastPage()) {
                  profileCubit.isLoadingPage = true;
                  profileCubit.getNextPage(profileProvider.pageNum);
                }
              }),
            children: list,
          )),
    );
  }

  Widget _loadingProgress(MainTheme theme) {
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

  Widget _loadingRefreshProgress(MainTheme theme) {
    return BlocSelector<ProfileCubit, ProfileState, bool>(
        selector: (state) => state is ProfileRefreshLoadingState,
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
}
