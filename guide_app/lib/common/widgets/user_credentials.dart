import 'package:flutter/widgets.dart';

class UserCredentials extends InheritedWidget {
  const UserCredentials(
      {super.key, required this.email, required this.token, child})
      : super(child: child);

  final String email;
  final String token;

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
}
