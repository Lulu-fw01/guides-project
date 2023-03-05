import 'package:guide_app/common/client/i_guide_client.dart';
import 'package:guide_app/common/dto/new_guide_dto.dart';
import 'package:guide_app/common/mixin/exception_response_mixin.dart';
import 'package:guide_app/common/repository/guide/i_guide_repository.dart';

class GuideRepository with ExceptionResponseMixin implements IGuideRepository {
  GuideRepository(this.email, this.guideClient);
  final IGuideClient guideClient;
  final String email;
  @override
  Future<void> addNewGuide(String title, String guideContent) async {
    final newGuideDto = NewGuideDto(email, title, guideContent);
    final response = await guideClient.createGuide(newGuideDto);
    if (response.statusCode != 200) {
      throwError(response);
    }
  }
}
