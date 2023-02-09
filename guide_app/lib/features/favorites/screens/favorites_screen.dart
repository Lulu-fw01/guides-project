import 'package:flutter/widgets.dart';
import 'package:guide_app/common/widgets/guide_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [GuideCard()],);
  }
}
