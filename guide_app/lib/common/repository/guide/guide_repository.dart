import 'package:guide_app/common/client/i_guide_client.dart';
import 'package:guide_app/common/repository/guide/i_guide_repository.dart';

class GuideRepository implements IGuideRepository {
  GuideRepository(this.guideClient);
  final IGuideClient guideClient;
  @override
  void addNewGuide(String title, String guideContent) {}
}
