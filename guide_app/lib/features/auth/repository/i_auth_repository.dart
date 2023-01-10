abstract class IAuthRepository {
  void Function()? onSuccessAuth;
  Future<Object> signIn();
  Future<Object> signUp();
}
