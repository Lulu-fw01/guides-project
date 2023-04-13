import 'package:flutter/widgets.dart';

import '../dto/user_info_dto.dart';

class UserCredentials extends InheritedWidget {
  const UserCredentials(
      {super.key,
      required this.email,
      required this.token,
      required this.userInfo,
      child})
      : super(child: child);

  final String email;
  final String token;
  final UserInfoDto userInfo;

  static UserCredentials? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserCredentials>();
  }

  static UserCredentials of(BuildContext context) {
    final UserCredentials? result = maybeOf(context);
    assert(result != null, 'No UserCredentials found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant UserCredentials oldCredentials) =>
      email != oldCredentials.email || token != oldCredentials.token;

  String get userLogin => userInfo.login;
}
