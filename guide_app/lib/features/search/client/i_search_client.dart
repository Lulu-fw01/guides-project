import 'package:http/http.dart' as http;

abstract class ISearchClient {
  Future<http.Response> searchByGuideTitle(
      String title, int pageNum, int pageSize);
  Future<http.Response> searchByCategoryName(
      String category, int pageNum, int pageSize);
  Future<http.Response> searchByAuthorLogin(
      String login, int pageNum, int pageSize);
}
