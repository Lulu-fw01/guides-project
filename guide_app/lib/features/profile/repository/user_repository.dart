import 'package:guide_app/features/profile/client/i_user_client.dart';
import 'package:guide_app/features/profile/dto/user_info_dto.dart';
import 'package:guide_app/features/profile/repository/i_user_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository(this.userClient);
  final IUserClient userClient;

  @override
  Future<UserInfoDto> getUserInfo(String email) {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }
}
