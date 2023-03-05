import 'dart:convert';

import 'package:guide_app/common/api/api_constants.dart';
import 'package:guide_app/common/client/i_guide_client.dart';
import 'package:guide_app/common/dto/new_guide_dto.dart';
import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:http/http.dart' as http;

class GuideClient implements IGuideClient {
  GuideClient(this.token);
  final String token;

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
}
