import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../common/api/api_constants.dart';
import '../../../common/exceptions/app_exception.dart';
import '../dto/favorite_item_dto.dart';
import 'i_favorites_client.dart';

/// Client for working with favorites guides.
class FavoritesClient implements IFavoritesClient {
  FavoritesClient(this.token);
  final String token;

  /// Add guides to favorites.
  /// <p>
  /// [favoriteItemDto] - Dto with user Email and guide id.
  /// <p>
  /// Returns [http.Response].
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> addToFavorites(FavoriteItemDto favoriteItemDto) async {
    var url = Uri.parse(ApiConstants.favoritesUri);
    try {
      var response = await http.post(url,
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode(favoriteItemDto));
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  /// Get page of favorites guides by user.
  /// Pageable request.
  /// <p>
  /// [userEmail] - user's email.
  /// [pageNum] - number of page.
  /// [pageSize] - size of page.
  /// <p>
  /// Returns [http.Response].
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> getFavorites(
      String userEmail, int pageNum, int pageSize) async {
    var url =
        Uri.parse('${ApiConstants.favoritesUri}/$userEmail/$pageNum/$pageSize');
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": 'Bearer $token',
          "Content-Type": "application/json"
        },
      );
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  /// Remove guide from favorites.
  /// <p>
  /// [favoriteItemDto] - Dto with user Email and guide id.
  /// <p>
  /// Returns [http.Response].
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> removeFromFavorites(
      FavoriteItemDto favoriteItemDto) async {
    var url = Uri.parse(ApiConstants.favoritesUri);
    try {
      var response = await http.delete(url,
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode(favoriteItemDto));
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
