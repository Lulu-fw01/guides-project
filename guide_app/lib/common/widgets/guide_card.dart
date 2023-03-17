import 'package:flutter/material.dart';
import 'package:guide_app/common/dto/guide_card_dto.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:provider/provider.dart';

/// Guide card widget.
/// v1.
/// Author: @Lulu-fw01
class GuideCard extends StatelessWidget {
  const GuideCard(this.guideCardDto, {super.key});

  /// Guide card data.
  final GuideCardDto guideCardDto;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom:
                BorderSide(width: 2, color: theme.onSurface.withOpacity(0.5))),
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
                IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
