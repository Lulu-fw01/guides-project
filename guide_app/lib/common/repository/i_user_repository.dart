import '../dto/user_info_dto.dart';

abstract class IUserRepository {
  Future<UserInfoDto> getUserInfo();
  Future<UserInfoDto> getUserInfoOutsideToken(String email, String token);
}
