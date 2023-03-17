import 'package:flutter_quill/flutter_quill.dart';
import 'package:guide_app/common/dto/guide_cards_page.dart';

/// Guide repository interface.
abstract class IGuideRepository {
  Future<void> addNewGuide(Document quillDocument);
  Future<GuideCardsPage> getGuideCardsByUser(int pageNumber);
}
