import 'package:guide_app/features/profile/client/i_user_client.dart';
import 'package:http/http.dart';

class UserClient implements IUserClient {
  @override
  Future<Response> getUserInfo(String email) {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }
}
