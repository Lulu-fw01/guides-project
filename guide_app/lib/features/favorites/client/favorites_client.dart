import 'package:http/http.dart' as http;

import '../dto/favorite_item_dto.dart';
import 'i_favorites_client.dart';

/// Client for working with favorites guides.
class FavoritesClient implements IFavoritesClient {
  FavoritesClient(this.token);
  final String token;

  @override
  Future<http.Response> addToFavorites(FavoriteItemDto favoriteItemDto) {
    // TODO: implement addToFavorites
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  @override
  Future<http.Response> removeFromFavorites(FavoriteItemDto favoriteItemDto) {
    // TODO: implement removeFromFavorites
    throw UnimplementedError();
  }
}
