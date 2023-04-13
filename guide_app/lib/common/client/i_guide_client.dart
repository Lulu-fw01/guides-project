import 'package:http/http.dart' as http;

import '../dto/new_guide_dto.dart';
import '../dto/user_guide_page_dto.dart';

/// Guide client interface.
abstract class IGuideClient {
  Future<http.Response> createGuide(NewGuideDto newGuide);
  Future<http.Response> getGuideCardsByUser(UserGuidePageDto userGuidePageDto);
  Future<http.Response> getGuideById(int guideId);
  Future<http.Response> removeGuide(int guideId);
}
