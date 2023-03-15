import 'package:flutter/material.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/common/widgets/guide_card.dart';
import 'package:guide_app/features/profile/cubit/profile_cubit.dart';
import 'package:guide_app/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

/// Part of [ProfileContent] where we draw guide cards.
class CardsList extends StatelessWidget {
  CardsList({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final profileCubit = Provider.of<ProfileCubit>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final theme = Provider.of<MainTheme>(context);

    return ListView.separated(
        key: const PageStorageKey('profile_page_cards'),
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.offset ==
                _scrollController.position.maxScrollExtent) {
              profileCubit.getNextPage(profileProvider.pageNum);
            }
          }),
        itemBuilder: (BuildContext context, int index) =>
            GuideCard(profileProvider.guideCardDtos[index]),
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 3,
              color: theme.onSurface,
            ),
        itemCount: profileProvider.guideCardDtos.length);
  }
}
