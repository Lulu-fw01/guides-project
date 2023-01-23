import 'package:guide_app/features/auth/client/dto/auth_dto.dart';
import 'package:guide_app/features/auth/client/i_auth_client.dart';
import 'package:guide_app/features/auth/repository/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository(this.client);
  final IAuthClient client;

  @override
  Future<String> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<String> signUp(String email, String password) {
    return client.signUp(AuthDto(email, password));
  }
}
