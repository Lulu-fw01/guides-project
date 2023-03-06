import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/common/repository/guide/i_guide_repository.dart';
import 'package:meta/meta.dart';

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
}
