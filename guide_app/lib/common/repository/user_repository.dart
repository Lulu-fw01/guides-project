import 'dart:convert';

import '../../../common/mixin/exception_response_mixin.dart';
import '../../../common/client/i_user_client.dart';
import '../dto/user_info_dto.dart';
import '../exceptions/app_exception.dart';
import 'i_user_repository.dart';

class UserRepository with ExceptionResponseMixin implements IUserRepository {
  UserRepository(this.userClient, {this.email});
  final IUserClient userClient;
  final String? email;

  @override
  Future<UserInfoDto> getUserInfo() async {
    // TODO refactoring.
    if (email == null) {
      throw UnauthorizedException();
    }
    final response = await userClient.getUserInfo(email!);
    if (response.statusCode != 200) {
      throwError(response);
    }
    return UserInfoDto.fromJson(jsonDecode(response.body));
  }

  /// Get user's information by email.
  @override
  Future<UserInfoDto> getUserInfoOutsideToken(
      String userEmail, String token) async {
    final response = await userClient.getUserInfoOutsideToken(userEmail, token);
    if (response.statusCode != 200) {
      throwError(response);
    }
    return UserInfoDto.fromJson(jsonDecode(response.body));
  }
}
