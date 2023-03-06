import 'package:guide_app/common/dto/new_guide_dto.dart';
import 'package:http/http.dart' as http;

abstract class IGuideClient {
  Future<http.Response> createGuide(NewGuideDto newGuide);
}