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
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                    style: theme.titleText,
                  ),
                  Row(
                    children: [
                      Text(
                        guideCardDto.editDate,
                        style: theme.smallInfoText,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              //Icon(Icons.bookmark)
              IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              )
            ],
          )
        ],
      ),
    );
  }
}
