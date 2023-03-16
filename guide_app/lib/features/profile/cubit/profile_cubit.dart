import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:guide_app/common/dto/guide_cards_page.dart';
import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/common/repository/guide/i_guide_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.guideRepository}) : super(ProfileInitialState());
  final IGuideRepository guideRepository;
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

  void refresh() {
    getNextPage(0);
  }
}
