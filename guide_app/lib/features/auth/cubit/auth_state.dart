part of 'auth_cubit.dart';

/// States of [AuthScreen].

@immutable
abstract class AuthState {}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  AuthErrorState(this.errorMessage);
  final String errorMessage;
}
