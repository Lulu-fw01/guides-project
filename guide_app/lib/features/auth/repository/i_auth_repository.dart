/// Class for user authentication in app.
abstract class IAuthRepository {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
}
