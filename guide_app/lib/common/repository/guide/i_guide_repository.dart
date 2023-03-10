import 'package:flutter_quill/flutter_quill.dart';
import 'package:guide_app/common/dto/guide_card_dto.dart';

/// Guide repository interface.
abstract class IGuideRepository {
  Future<void> addNewGuide(Document quillDocument);
  Future<List<GuideCardDto>> getGuideCardsByUser(String email, int pageNumber);
}
