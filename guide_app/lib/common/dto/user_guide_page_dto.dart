import 'package:json_annotation/json_annotation.dart';

part 'user_guide_page_dto.g.dart';

/// Dto for requesting guide cards by user.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class UserGuidePageDto {
  UserGuidePageDto(this.email, this.pageNumber, this.pageSize);
  final String email;
  final int pageNumber;
  final int pageSize;

  factory UserGuidePageDto.standardPage(String email, int pageNumber) {
    return UserGuidePageDto(email, pageNumber, 8);
  }

  Map<String, dynamic> toJson() => _$UserGuidePageDtoToJson(this);
}
