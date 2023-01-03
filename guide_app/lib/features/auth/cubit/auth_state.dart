part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthCubitInitial extends AuthState {}

class Login extends AuthState {}

class SignUp extends AuthState {}

class Loading extends AuthState {}
