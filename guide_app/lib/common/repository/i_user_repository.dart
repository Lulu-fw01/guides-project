import '../dto/user_info_dto.dart';

abstract class IUserRepository {
  Future<UserInfoDto> getUserInfo(String email);
  Future<UserInfoDto> getUserInfoOutsideToken(String email, String token);
}
