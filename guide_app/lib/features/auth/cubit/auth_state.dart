part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthLoginState extends AuthState {}

class AuthSignUpState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  AuthErrorState({this.errorMessage});
  final String? errorMessage;
}
