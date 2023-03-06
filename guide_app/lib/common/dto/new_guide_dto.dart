import 'package:json_annotation/json_annotation.dart';

part 'new_guide_dto.g.dart';

/// New guide dto.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class NewGuideDto {
  NewGuideDto(this.email, this.title, this.content);
  @JsonKey(name: 'creatorEmail')
  final String email;
  final String title;
  @JsonKey(name: 'fileBytes')
  final String content;

  Map<String, dynamic> toJson() => _$NewGuideDtoToJson(this);
}
