import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dto/guide_card_dto.dart';
import '../themes/main_theme.dart';
import 'guide_card_popup_menu_btn.dart';

/// Guide card widget.
/// v1.
/// Author: @Lulu-fw01
class GuideCard extends StatelessWidget {
  const GuideCard(
    this.guideCardDto, {
    super.key,
    required this.onClick,
    required this.onFavoritesButtonClick,
    this.onEdit,
    this.onRemove,
  });

  /// Guide card data.
  final GuideCardDto guideCardDto;
  final void Function() onClick;
  final void Function() onFavoritesButtonClick;
  final void Function()? onEdit;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 2, color: theme.onSurface.withOpacity(0.5))),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            guideCardDto.author,
                            style: theme.smallInfoTextAuthor,
                          )
                        ],
                      ),
                      Text(
                        guideCardDto.guideName,
                        style: theme.guideCardTitle,
                      ),
                      Row(
                        children: [
                          Text(
                            guideCardDto.getEditDateAsText(),
                            style: theme.smallInfoText,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: theme.infoColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        onFavoritesButtonClick();
                      },
                      icon: guideCardDto.addedToFavorites
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_add_outlined)),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.more_horiz),
                  // )
                  GuideCardPopupMenuBtn(
                    onEdit: onEdit,
                    onRemove: onRemove,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
