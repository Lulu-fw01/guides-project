import '../../../common/dto/guide_cards_page.dart';
import '../client/i_favorites_client.dart';
import 'i_favorites_repository.dart';

/// Repository for working with favorites guides.
class FavoritesRepository implements IFavoritesRepository {
  FavoritesRepository({required this.email, required this.favoritesClient});
  final IFavoritesClient favoritesClient;
  final String email;

  @override
  Future<void> addToFavorites(int guideId) {
    // TODO: implement addToFavorites
    throw UnimplementedError();
  }

  @override
  Future<GuideCardsPage> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromFavorites(int guideId) {
    // TODO: implement removeFromFavorites
    throw UnimplementedError();
  }
}
