/// Class for user authentication in app.
abstract class IAuthRepository {
  /// Params:
  ///   - identifier - email or login;
  ///   - user's password.
  Future<String> signIn(String identifier, String password);
  Future<String> signUp(String login, String email, String password);
}
