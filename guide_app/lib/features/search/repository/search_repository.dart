import 'dart:convert';

import '../../../common/dto/guide_cards_page.dart';
import '../../../common/mixin/exception_response_mixin.dart';
import '../client/i_search_client.dart';
import 'i_search_repository.dart';

/// Search repository.
class SearchRepository
    with ExceptionResponseMixin
    implements ISearchRepository {
  SearchRepository({required this.searchClient});
  final ISearchClient searchClient;

  /// Find guides by name.
  /// [guideName] - search phrase.
  /// [pageNum] - page number.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<GuideCardsPage> searchGuidesByTitle(
      String guideName, int pageNum) async {
    final response =
        await searchClient.searchByGuideName(guideName, pageNum, 8);
    if (response.statusCode != 200) {
      throwError(response);
    }
    final dynamic data = jsonDecode(response.body);
    return GuideCardsPage.fromJson(data);
  }
}
