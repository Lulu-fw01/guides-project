import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitLoading());

  void login() {
    emit(InitAuthorized());
  }

  void logout() {
    emit(InitUnauthorized());
  }
}
