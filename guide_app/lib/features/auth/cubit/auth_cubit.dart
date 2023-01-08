import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:guide_app/features/auth/repository/i_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthLoginState());
  final IAuthRepository authRepository;

  void goToSignUp() {
    emit(AuthSignUpState());
  }

  void goToLogin() {
    emit(AuthLoginState());
  }

  /// Login function.
  void signIn(String login, String password) {}

  void signUp(String name, String login, String email, String password) {}
}
