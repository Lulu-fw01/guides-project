import 'package:json_annotation/json_annotation.dart';

part 'edit_guide_dto.g.dart';

/// Edit guide dto.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class EditGuideDto {
  EditGuideDto(this.id, this.title, this.content);
  final int id;
  final String title;
  @JsonKey(name: 'contents')
  final String content;

  Map<String, dynamic> toJson() => _$EditGuideDtoToJson(this);
}