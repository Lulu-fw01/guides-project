import '../../../common/dto/guide_cards_page.dart';

abstract class ISearchRepository {
  Future<GuideCardsPage> searchGuidesByTitle(String guideName, int pageNum);
}
