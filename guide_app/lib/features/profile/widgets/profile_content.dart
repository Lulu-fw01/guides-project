import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import '../../../common/themes/main_theme.dart';
import '../../../common/widgets/guide_card.dart';
import '../cubit/profile_cubit.dart';
import '../provider/profile_provider.dart';

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
    final profileCubit = Provider.of<ProfileCubit>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final theme = Provider.of<MainTheme>(context);

    List<Widget> list = [];
    list.add(_loadingRefreshProgress(theme));
    list.addAll(profileProvider.guideCardDtos
        .map(
          (e) => GuideCard(e),
        )
        .toList());
    list.add(_loadingProgress(theme));

    return RefreshIndicator(
        color: theme.onSurface,
        onRefresh: () => onRefresh(profileProvider, profileCubit),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          key: const PageStorageKey('profile_page_cards'),
          controller: _scrollController
            ..addListener(() {
              // TODO check last page.
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
        ));
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


// TODO remove later
// return RefreshIndicator(
//       color: theme.onSurface,
//       onRefresh: () => onRefresh(profileProvider, profileCubit),
//       child: ListView.separated(
//           physics: const AlwaysScrollableScrollPhysics(),
//           key: const PageStorageKey('profile_page_cards'),
//           controller: _scrollController
//             ..addListener(() {
//               // TODO check last page.
//               if (_scrollController.offset ==
//                       _scrollController.position.maxScrollExtent &&
//                   !profileCubit.isLoadingPage) {
//                 profileCubit.isLoadingPage = true;
//                 profileCubit.getNextPage(profileProvider.pageNum);
//               }
//             }),
//           itemBuilder: (BuildContext context, int index) {
//             if (index == totalLength - 1) {
//               return BlocSelector<ProfileCubit, ProfileState, bool>(
//                   selector: (state) => state is ProfileLoadingState,
//                   builder: (context, isLoading) => isLoading
//                       ? Center(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 8, bottom: 8),
//                             child: CircularProgressIndicator(
//                               color: theme.onSurface,
//                             ),
//                           ),
//                         )
//                       : Container());
//             }
//             if (index == 0) {
//               return profileProvider.userInfoDto != null
//                   ? UserInfo(userInfoDto: profileProvider.userInfoDto!)
//                   : Container(height: 30,);
//             }
//             return GuideCard(profileProvider.guideCardDtos[index - 1]);
//           },
//           separatorBuilder: (BuildContext context, int index) => Divider(
//                 height: 3,
//                 color: theme.onSurface,
//               ),
//           itemCount: totalLength),
//     );
