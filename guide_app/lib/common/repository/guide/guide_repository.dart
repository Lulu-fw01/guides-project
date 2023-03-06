import 'dart:convert';
import 'dart:developer';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:guide_app/common/client/i_guide_client.dart';
import 'package:guide_app/common/dto/new_guide_dto.dart';
import 'package:guide_app/common/mixin/exception_response_mixin.dart';
import 'package:guide_app/common/repository/guide/i_guide_repository.dart';

class GuideRepository with ExceptionResponseMixin implements IGuideRepository {
  GuideRepository(this.email, this.guideClient);
  final IGuideClient guideClient;
  final String email;

  /// Create new guide.
  /// [quillDocument] flutter_quill document.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<void> addNewGuide(Document quillDocument) async {
    final delta = quillDocument.toDelta();
    final operations = delta.toList();
    String title = "Без названия";
    // Trying to get title from document.
    // TODO make more interesting.
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

    final newGuideDto = NewGuideDto(email, title, jsonGuide);
    final response = await guideClient.createGuide(newGuideDto);
    if (response.statusCode != 200) {
      throwError(response);
    }
  }
}
