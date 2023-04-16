import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../common/dto/user_info_dto.dart';
import '../common/exceptions/app_exception.dart';
import '../common/repository/credentials_repository.dart';
import '../common/repository/user_repository.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit(
      {required this.credentialsRepository, required this.userInfoRepository})
      : super(InitCubitInitial());

  final CredentialsRepository credentialsRepository;
  final UserRepository userInfoRepository;

  void start() async {
    // Can't use other features of app without email or jwt.
    final email = await credentialsRepository.getEmail();
    final token = await credentialsRepository.getToken();
    if (token != null && email != null) {
      _tryAuthorize(email, token);
    } else {
      emit(InitUnauthorized());
    }
  }

  Future<void> _tryAuthorize(String email, String token) async {
    try {
      final userInfo =
          await userInfoRepository.getUserInfoOutsideToken(email, token);
      emit(InitAuthorized(email, token, userInfo));
    } on ResponseException catch (e) {
      emit(InitUnauthorized());
    } on AppException catch (e) {
      emit(InitUnauthorized());
    } catch (e) {
      emit(InitUnauthorized());
    }
  }

  void login(String email, String token) {
    _tryAuthorize(email, token);
  }

  void logout() {
    credentialsRepository.removeToken();
    emit(InitUnauthorized());
  }
}
