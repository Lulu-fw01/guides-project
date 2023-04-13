import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../exceptions/app_exception.dart';
import '../repository/guide/i_guide_repository.dart';

part 'guide_utils_state.dart';

/// Cubit for doing manipulations with guide.
class GuideUtilsCubit extends Cubit<GuideUtilsState> {
  GuideUtilsCubit({required this.guideRepository}) : super(GuideUtilsInitial());
  final IGuideRepository guideRepository;

  final List<void Function(int)> _onGuideRemoved = [];

  void addOnGuideRemoveListener(void Function(int) listener) {
    _onGuideRemoved.add(listener);
  }

  /// Remove guide.
  /// [guideId] - guide id.
  void removeGuide(int guideId) async {
    try {
      await guideRepository.removeGuide(guideId);
      for (var func in _onGuideRemoved) {
        func(guideId);
      }
      emit(SuccessRemoveGuideState());
    } on ResponseException catch (e) {
      String message = e.responseBody != null ? e.responseBody!.message : '';
      //log.warning('Got ResponseException with message: $message', e);
      emit(ErrorRemoveGuideState());
    } on AppException catch (e) {
      emit(ErrorRemoveGuideState());
    }
  }
}
