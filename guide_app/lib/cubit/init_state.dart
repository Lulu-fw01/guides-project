part of 'init_cubit.dart';

@immutable
abstract class InitState {}

class InitCubitInitial extends InitState {}

class InitAuthorized extends InitState {
  InitAuthorized(this.email, this.token, this.userInfo);
  final String token;
  final String email;
  final UserInfoDto userInfo;
}

class InitUnauthorized extends InitState {}
