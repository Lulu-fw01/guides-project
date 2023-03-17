import 'dart:convert';
import 'dart:developer';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:guide_app/common/client/i_guide_client.dart';
import 'package:guide_app/common/dto/guide_card_dto.dart';
import 'package:guide_app/common/dto/guide_cards_page.dart';
import 'package:guide_app/common/dto/new_guide_dto.dart';
import 'package:guide_app/common/dto/user_guide_page_dto.dart';
import 'package:guide_app/common/mixin/exception_response_mixin.dart';
import 'package:guide_app/common/repository/guide/i_guide_repository.dart';
import 'package:http/http.dart';

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
    // TODO название не может быть более 50 символов.
    for (var operation in operations) {
      if (operation.isInsert &&
          operation.data is String &&
          operation.data.toString().length > 1) {
        title = operation.data.toString().replaceAll('\n', "");
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

  /// Get list of guides by user.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<GuideCardsPage> getGuideCardsByUser(int pageNumber) async {
    // TODO remove later this delay only for testing.
    await Future.delayed(Duration(seconds: 2));
    if (pageNumber < 0) {
      // TODO throw exception.
    }
    final dto = UserGuidePageDto.standardPage(email, pageNumber);
    final response = await guideClient.getGuideCardsByUser(dto);
    if (response.statusCode != 200) {
      throwError(response);
    }
    final dynamic data = jsonDecode(response.body);
    return GuideCardsPage.fromJson(data);
  }
}
