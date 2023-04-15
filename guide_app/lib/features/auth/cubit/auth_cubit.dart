import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/features/auth/repository/i_auth_repository.dart';

part 'auth_state.dart';

/// Cubit of auth screen.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository, this.onSuccessAuth) : super(AuthInitState());
  final IAuthRepository authRepository;
  final void Function(String email, String token) onSuccessAuth;

  /// Login function.
  void signIn(String email, String password) {
    emit(AuthLoadingState());
    authRepository.signIn(email, password).then((token) {
      debugPrint("Got token.");
      onSuccessAuth(email, token);
    }).catchError((e) {
      emit(AuthErrorState((e as ResponseException).responseBody != null
          ? e.responseBody!.message
          : ''));
    }, test: (error) => error is ResponseException).catchError(
      (e) {
        emit(AuthErrorState(
            (e as FetchDataException).message != null ? e.message! : ''));
      },
      test: (error) => error is FetchDataException,
    );
  }

  /// Sign up function.
  void signUp(String login, String email, String password) {
    emit(AuthLoadingState());
    authRepository.signUp(login, email, password).then((token) {
      debugPrint("Got token.");
      onSuccessAuth(email, token);
    }).catchError((e) {
      emit(AuthErrorState((e as ResponseException).responseBody != null
          ? e.responseBody!.message
          : ''));
    }, test: (error) => error is ResponseException).catchError(
      (e) {
        emit(AuthErrorState(
            (e as AppException).message != null ? e.message! : ''));
      },
      test: (error) => error is AppException,
    );
    // TODO rewrite and add logic for other errors.
  }
}
