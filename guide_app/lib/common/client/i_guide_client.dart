import 'package:guide_app/common/dto/new_guide_dto.dart';
import 'package:guide_app/common/dto/user_guide_page_dto.dart';
import 'package:http/http.dart' as http;

/// Guide client interface.
abstract class IGuideClient {
  Future<http.Response> createGuide(NewGuideDto newGuide);

  Future<http.Response> getGuideCardsByUser(UserGuidePageDto userGuidePageDto);

  Future<http.Response> getGuideById(int guideId);
}
