import 'dart:convert';

import '../../../common/mixin/exception_response_mixin.dart';
import '../../../common/client/i_user_client.dart';
import '../dto/user_info_dto.dart';
import 'i_user_repository.dart';

class UserRepository with ExceptionResponseMixin implements IUserRepository {
  UserRepository(this.userClient);
  final IUserClient userClient;

  @override
  Future<UserInfoDto> getUserInfo(String email) {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  /// Get user's information by email.
  @override
  Future<UserInfoDto> getUserInfoOutsideToken(
      String email, String token) async {
    final response = await userClient.getUserInfoOutsideToken(email, token);
    if (response.statusCode != 200) {
      throwError(response);
    }
    return UserInfoDto.fromJson(jsonDecode(response.body));
  }
}
