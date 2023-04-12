import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:guide_app/common/repository/credentials_repository.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  // TODO addr [CredentialsRepository] here.
  // Can't use other features of app without email or jwt.
  InitCubit(String? email, String? token, {required this.credentialsRepository})
      : super((token != null && email != null)
            ? InitAuthorized(email, token)
            : InitUnauthorized());

  final CredentialsRepository credentialsRepository;

  void login(String email, String token) {
    emit(InitAuthorized(email, token));
  }

  void logout() {
    credentialsRepository.removeToken();
    emit(InitUnauthorized());
  }
}
