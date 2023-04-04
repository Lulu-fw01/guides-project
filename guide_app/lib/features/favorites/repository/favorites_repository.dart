import 'dart:convert';

import '../../../common/dto/guide_cards_page.dart';
import '../../../common/mixin/exception_response_mixin.dart';
import '../client/i_favorites_client.dart';
import '../dto/favorite_item_dto.dart';
import 'i_favorites_repository.dart';

/// Repository for working with favorites guides.
class FavoritesRepository
    with ExceptionResponseMixin
    implements IFavoritesRepository {
  FavoritesRepository({required this.email, required this.favoritesClient});
  final IFavoritesClient favoritesClient;
  final String email;

  /// Add guide to favorites.
  /// [guideId] - guide id.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<void> addToFavorites(int guideId) async {
    final dto = FavoriteItemDto(guideId, email);
    final response = await favoritesClient.addToFavorites(dto);
    if (response.statusCode != 200) {
      throwError(response);
    }
  }

  /// Get page of user's favorite guides.
  /// [cursor] - id of the lat guide
  /// in last page. [cursor] is equal to -1
  /// if requesting first page.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<GuideCardsPage> getFavorites(int cursor) async {
    // TODO remove later this delay only for testing.
    await Future.delayed(const Duration(seconds: 2));

    final response = await favoritesClient.getFavorites(email, cursor, 8);
    if (response.statusCode != 200) {
      throwError(response);
    }
    final dynamic data = jsonDecode(response.body);
    return GuideCardsPage.fromJson(data);
  }

  /// Remove guide from favorites.
  /// [guideId] - id of the guide
  /// to be removed from favorites.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<void> removeFromFavorites(int guideId) async {
    final dto = FavoriteItemDto(guideId, email);
    final response = await favoritesClient.removeFromFavorites(dto);
    if (response.statusCode != 200) {
      throwError(response);
    }
  }
}
