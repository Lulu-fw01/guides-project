import 'package:flutter/material.dart';
import 'package:guide_app/common/dto/guide_card_dto.dart';
import 'package:guide_app/common/themes/main_theme.dart';
import 'package:guide_app/common/widgets/guide_card.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);

    final guideCards = [
      // GuideCardDto(1, 'Lulu-fw01', 'My first guide kkkkkkk kkkkkkk kkkkkkkkk',
      //     '01.02.2023'),
      // GuideCardDto(1, 'Lulu-fw01', 'My second guide', '01.02.2023'),
      // GuideCardDto(2, 'Lulu-fw01', 'My fucking third guide', '01.02.2023'),
      // GuideCardDto(3, 'Lulu-fw01', 'My fourth guide', '01.02.2023'),
      // GuideCardDto(4, 'Lulu-fw01', 'My fifth guide', '01.02.2023'),
      // GuideCardDto(5, 'Lulu-fw01', 'My whatever guide', '01.02.2023'),
      // GuideCardDto(6, 'Lulu-fw01', 'Another one guide by me', '01.02.2023')
    ];
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            GuideCard(guideCards[index]),
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 3,
              color: theme.onSurface,
            ),
        itemCount: guideCards.length);
  }
}
