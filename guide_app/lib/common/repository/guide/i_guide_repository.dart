import 'package:flutter_quill/flutter_quill.dart';

import '../../dto/guide_cards_page.dart';
import '../../dto/guide_dto.dart';

/// Guide repository interface.
abstract class IGuideRepository {
  Future<void> addNewGuide(Document quillDocument);
  Future<GuideCardsPage> getGuideCardsByUser(int pageNumber);
  Future<GuideDto> getGuideById(int guideId);
  Future<void> removeGuide(int guideId);
  Future<void> updateGuide(int id, Document quillDocument);
}
