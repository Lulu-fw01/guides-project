import 'package:shared_preferences/shared_preferences.dart';

/// Repository for working with JWT in shared preferences.
class CredentialsRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const tokenKey = 'token';
  static const emailKey = 'email';

  /// Save JWT token in shared preferences.
  void saveToken(String token) async {
    final instance = await _prefs;
    await instance.setString(tokenKey, token);
  }

  /// Get token from shared preferences.
  Future<String?> getToken() async {
    final instance = await _prefs;
    return instance.getString(tokenKey);
  }

  void removeToken() async {
    final instance = await _prefs;
    instance.remove(tokenKey);
  }

  /// Get save user email.
  void saveEmail(String email) async {
    final instance = await _prefs;
    await instance.setString(emailKey, email);
  }

  /// Get user email.
  Future<String?> getEmail() async {
    final instance = await _prefs;
    return instance.getString(emailKey);
  }
}
