import 'package:http/http.dart' as http;

import '../../../common/api/api_constants.dart';
import '../../../common/exceptions/app_exception.dart';
import 'i_search_client.dart';

class SearchClient implements ISearchClient {
  SearchClient(this.token);
  final String token;

  @override
  Future<http.Response> searchByAuthorLogin(
      String login, int pageNum, int pageSize) {
    // TODO: implement searchByAuthorLogin
    throw UnimplementedError();
  }

  @override
  Future<http.Response> searchByCategoryName(
      String category, int pageNum, int pageSize) {
    // TODO: implement searchByCategoryName
    throw UnimplementedError();
  }

  /// Search guides by name.
  ///
  /// [guideName] - search phrase.
  /// [page] - page number.
  /// [pageSize] - page size.
  /// Returns [http.Response] which contains page with guides.
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> searchByGuideName(
      String guideName, int pageNum, int pageSize) {
    final url = Uri.parse(
        "${ApiConstants.searchByTitleUri}/$guideName/$pageNum/$pageSize");
    try {
      var response = http.get(url, headers: {
        "Authorization": 'Bearer $token',
        "Content-Type": "application/json"
      });
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
