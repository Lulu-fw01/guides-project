import 'package:guide_app/features/auth/repository/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({this.onSuccessAuth});

  @override
  void Function()? onSuccessAuth;
  
  @override
  Future<Object> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Object> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}