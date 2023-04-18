import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:meta/meta.dart';

import '../../../common/exceptions/app_exception.dart';
import '../../../common/repository/guide/i_guide_repository.dart';

part 'guide_state.dart';

class GuideCubit extends Cubit<GuideState> {
  GuideCubit(this.guideRepository) : super(GuideInitial());
  final IGuideRepository guideRepository;

  /// Create new guide.
  ///
  /// [quillDocument] - guide in flutter_quill library format.
  void createNewGuide(Document quillDocument) {
    log("Starting guide creation.");
    emit(GuideLoadingState());

    guideRepository.addNewGuide(quillDocument).catchError((e) {
      log('Caught error with creating guide', error: e);
      emit(GuideErrorState((e as ResponseException).responseBody != null
          ? e.responseBody!.message
          : ''));
    }, test: (error) => error is ResponseException).catchError(
      (e) {
        log('Caught error with creating guide', error: e);
        emit(GuideErrorState(
            (e as FetchDataException).message != null ? e.message! : ''));
      },
      test: (error) => error is FetchDataException,
    ).then((value) => emit(GuideSuccessState()));
  }

  /// Update guide guide.
  ///
  /// [id] - guide id.
  /// [quillDocument] - guide in flutter_quill library format.
  void updateGuide(int id, Document quillDocument) async {
    try {
      await guideRepository.updateGuide(id, quillDocument);
      emit(GuideSuccessState());
    } on ResponseException catch (e) {
      String message = e.responseBody != null ? e.responseBody!.message : '';
      log('Caught error with creating guide', error: e);
      emit(GuideErrorState(message));
    } on AppException catch (e) {
      final message = e.message != null ? e.message! : '';
      log('Caught error with creating guide', error: message);
      emit(GuideErrorState(message));
    }
  }
}
