part of 'init_cubit.dart';

@immutable
abstract class InitState {}

class InitCubitInitial extends InitState {}

class InitAuthorized extends InitState {
  InitAuthorized(this.email, this.token);
  final String token;
  final String email;
}

class InitUnauthorized extends InitState {}
