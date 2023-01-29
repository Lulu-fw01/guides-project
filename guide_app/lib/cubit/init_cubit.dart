import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit(bool hasToken)
      : super(hasToken ? InitAuthorized() : InitUnauthorized());

  void login() {
    emit(InitAuthorized());
  }

  void logout() {
    emit(InitUnauthorized());
  }
}
