import 'package:http/http.dart' as http;

import '../dto/favorite_item_dto.dart';

abstract class IFavoritesClient {
  Future<http.Response> addToFavorites(FavoriteItemDto favoriteItemDto);
  Future<http.Response> removeFromFavorites(FavoriteItemDto favoriteItemDto);
  Future<http.Response> getFavorites(
      String userEmail, int cursor, int pageSize);
}
