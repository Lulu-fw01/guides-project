import 'package:json_annotation/json_annotation.dart';

part 'guide_dto.g.dart';

/// Guide dto.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class GuideDto {
  GuideDto(this.id, this.login, this.title, this.content, this.editDate,
      this.isBlocked);

  final int id;

  @JsonKey(name: 'creatorLogin')
  final String login;

  final String title;

  // Quill delta in json format.
  @JsonKey(name: 'fileBytes')
  final String content;

  final DateTime editDate;

  final bool isBlocked;

  factory GuideDto.fromJson(Map<String, dynamic> json) =>
      _$GuideDtoFromJson(json);
}
