import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  // Can't use other features of app without email or jwt.
  InitCubit(String? email, String? token)
      : super((token != null && email != null) ? InitAuthorized(email, token) : InitUnauthorized());

  void login(String email, String token) {
    emit(InitAuthorized(email, token));
  }

  void logout() {
    emit(InitUnauthorized());
  }
}
