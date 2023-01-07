import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoginState());

  void goToSignUp() {
    emit(AuthSignUpState());
  }

  void goToLogin() {
    emit(AuthLoginState());
  }
}
