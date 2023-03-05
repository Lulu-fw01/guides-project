import 'dart:convert';
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

  void createNewGuide(Document quillDocument) {
    emit(GuideLoadingState());

    final delta = quillDocument.toDelta();
    final operations = delta.toList();
    String title = "Без названия";
    for (var operation in operations) {
      if (operation.isInsert &&
          operation.data is String &&
          operation.data.toString().length > 1) {
        title = operation.data.toString();
        break;
      }
    }

    log('New guide with title: $title');
    var jsonGuide = jsonEncode(delta.toJson());

    guideRepository.addNewGuide(title, jsonGuide).catchError((e) {
      emit(GuideErrorState((e as ResponseException).responseBody != null
          ? e.responseBody!.message
          : ''));
    }, test: (error) => error is ResponseException).catchError(
      (e) {
        emit(GuideErrorState(
            (e as FetchDataException).message != null ? e.message! : ''));
      },
      test: (error) => error is FetchDataException,
    ).then((value) => null);
  }
}
