import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/features/auth/repository/i_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository, this.onSuccessAuth) : super(AuthLoginState());
  final IAuthRepository authRepository;
  // TODO add token repo.
  final void Function() onSuccessAuth;

  void goToSignUp() async {
    emit(AuthSignUpState());
  }

  void goToLogin() {
    emit(AuthLoginState());
  }

  /// Login function.
  void signIn(String email, String password) {}

  void signUp(String email, String password) {
    emit(AuthLoadingState());
    authRepository.signUp(email, password).then((value) {
      debugPrint("Got token.");
      onSuccessAuth();
    }).catchError(
      (e) {
        emit(AuthErrorState(errorMessage: (e as AppException).message));
      },
      test: (error) => error is AppException,
    );
  }
}
