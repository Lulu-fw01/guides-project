import 'package:flutter/widgets.dart';

import '../../../common/dto/guide_card_dto.dart';

class FavoritesProvider extends ChangeNotifier {

  List<GuideCardDto> guideCardsDtos = [];

  /// Add guide to favorites or remove from favorites.
  void toggleFavorite(GuideCardDto guideCardDto) {
    if (guideCardDto.addedToFavorites) {

    } else {

    }
  }

  
}