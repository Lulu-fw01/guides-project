import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:guide_app/common/dto/guide_dto.dart';
import 'package:meta/meta.dart';

import '../../../../common/exceptions/app_exception.dart';
import '../../../../common/repository/guide/i_guide_repository.dart';

part 'guide_view_state.dart';

class GuideViewCubit extends Cubit<GuideViewState> {
  GuideViewCubit({required this.guideRepository}) : super(GuideViewInitial());

  final IGuideRepository guideRepository;

  /// Show guide guide.
  /// Download guide from server by it's ID.
  Future<void> showGuide(int guideId) async {
    emit(GuideViewLoadingState());

    try {
      final guide = await guideRepository.getGuideById(guideId);
      debugPrint("Guide ${guide.id} loaded");
      emit(GuideViewSuccessState(guide));
    } on ResponseException catch (e) {
      emit(GuideViewErrorState(
          e.responseBody != null ? e.responseBody!.message : ''));
    } on AppException catch (e) {
      emit(GuideViewErrorState(e.message != null ? e.message! : ''));
    }
  }
}
