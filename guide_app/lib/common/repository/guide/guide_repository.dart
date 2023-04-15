import 'dart:convert';
import 'dart:developer';

import 'package:flutter_quill/flutter_quill.dart';

import '../../client/i_guide_client.dart';
import '../../dto/guide_cards_page.dart';
import '../../dto/guide_dto.dart';
import '../../dto/new_guide_dto.dart';
import '../../dto/user_guide_page_dto.dart';
import '../../mixin/exception_response_mixin.dart';
import 'i_guide_repository.dart';

class GuideRepository with ExceptionResponseMixin implements IGuideRepository {
  GuideRepository({required this.email, required this.guideClient});
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
        title = operation.data.toString().replaceAll('\n', "");
        break;
      }
    }
    if (title.length > 84) {
      title = "${title.substring(0, 81)}...";
    }

    log('New guide with title: $title');
    var jsonGuide = jsonEncode(delta.toJson());

    final newGuideDto = NewGuideDto(email, title, jsonGuide);
    final response = await guideClient.createGuide(newGuideDto);
    if (response.statusCode != 200) {
      throwError(response);
    }
  }

  /// Get page of user's guides.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<GuideCardsPage> getGuideCardsByUser(int pageNumber) async {
    final dto = UserGuidePageDto.standardPage(email, pageNumber);
    final response = await guideClient.getGuideCardsByUser(dto);
    if (response.statusCode != 200) {
      throwError(response);
    }
    final dynamic data = jsonDecode(response.body);
    return GuideCardsPage.fromJson(data);
  }

  /// Get guide by id.
  /// [guideId] guide id.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<GuideDto> getGuideById(int guideId) async {
    final response = await guideClient.getGuideById(guideId);
    if (response.statusCode != 200) {
      throwError(response);
    }
    return GuideDto.fromJson(jsonDecode(response.body));
  }

  /// Remove guide.
  /// [guideId] guide id.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<void> removeGuide(int guideId) async {
    final response = await guideClient.removeGuide(guideId);
    if (response.statusCode != 200) {
      throwError(response);
    }
  }
}
