import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/dto/guide_card_dto.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  void toggleFavorite(GuideCardDto guideCardDto) {
    if (guideCardDto.addedToFavorites) {
      // TODO изменить в 
    } else {
      // TODO отметить в profile, search. добавить в favorites.
    }
  }
}
