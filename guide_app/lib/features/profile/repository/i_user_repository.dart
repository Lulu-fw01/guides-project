import 'package:guide_app/features/profile/dto/user_info_dto.dart';

abstract class IUserRepository {
  Future<UserInfoDto> getUserInfo(String email);
}
