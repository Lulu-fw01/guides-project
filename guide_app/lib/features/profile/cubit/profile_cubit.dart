import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import '../../../common/dto/guide_cards_page.dart';
import '../../../common/dto/user_info_dto.dart';
import '../../../common/exceptions/app_exception.dart';
import '../../../common/repository/guide/i_guide_repository.dart';
import '../../../common/repository/i_user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.guideRepository,
    required this.userRepository,
  }) : super(ProfileInitialState());
  final IGuideRepository guideRepository;
  final IUserRepository userRepository;
  bool isLoadingPage = false;

  void getNextPage(int pageNum) {
    emit(ProfileLoadingState());
    guideRepository.getGuideCardsByUser(pageNum).then((nextPage) {
      debugPrint("Got cards.");
      emit(ProfileSuccessState(nextPage));
    }).catchError((e) {
      emit(ProfileErrorState((e as ResponseException).responseBody != null
          ? e.responseBody!.message
          : ''));
    }, test: (error) => error is ResponseException).catchError(
      (e) {
        emit(ProfileErrorState(
            (e as AppException).message != null ? e.message! : ''));
      },
      test: (error) => error is AppException,
    );
  }

  Future<void> refresh() async {
    emit(ProfileRefreshLoadingState());
    try {
      final firstPage = await guideRepository.getGuideCardsByUser(0);
      debugPrint("Got cards.");
      final userInfo = await userRepository.getUserInfo();
      debugPrint("Got user info.");
      emit(ProfileRefreshSuccessState(firstPage, userInfo));
    } on ResponseException catch (e) {
      emit(ProfileErrorState(
          e.responseBody != null ? e.responseBody!.message : ''));
    } on AppException catch (e) {
      emit(ProfileErrorState(e.message != null ? e.message! : ''));
    }
  }
}
