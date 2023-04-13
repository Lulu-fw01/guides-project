import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api/api_constants.dart';
import '../dto/new_guide_dto.dart';
import '../dto/user_guide_page_dto.dart';
import '../exceptions/app_exception.dart';
import 'i_guide_client.dart';

class GuideClient implements IGuideClient {
  GuideClient(this.token);
  final String token;

  /// Create new guide.
  /// <p>
  /// [dto] - dto with new guide data.
  /// <p>
  /// Returns [http.Response].
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> createGuide(NewGuideDto dto) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.guideHandling);
    try {
      var response = await http.post(url,
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode(dto));
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  /// Get guides by user. Pageable request.
  /// <p>
  /// [dto] - dto with request.
  /// <p>
  /// Returns [http.Response].
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> getGuideCardsByUser(UserGuidePageDto dto) async {
    var url = Uri.parse(ApiConstants.getGuidesByUserUri);
    try {
      var response = await http.post(url,
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode(dto));
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  /// Get guide by id.
  /// <p>
  /// [guideId] - guide id.
  /// <p>
  /// Returns [http.Response].
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> getGuideById(int guideId) {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.guideHandling}/$guideId");
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

  /// RemoveGuide by id.
  /// <p>
  /// [guideId] - guide id.
  /// <p>
  /// Returns [http.Response].
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> removeGuide(int guideId) {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.guideHandling}/$guideId");
    try {
      var response = http.delete(url, headers: {
        "Authorization": 'Bearer $token',
        "Content-Type": "application/json"
      });
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
