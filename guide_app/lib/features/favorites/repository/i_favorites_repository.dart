import '../../../common/dto/guide_cards_page.dart';

abstract class IFavoritesRepository {
  Future<void> addToFavorites(int guideId);
  Future<void> removeFromFavorites(int guideId);
  Future<GuideCardsPage> getFavorites(int pageNum);
}
