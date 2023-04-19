import 'package:json_annotation/json_annotation.dart';

part 'user_info_dto.g.dart';

/// User info dto.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class UserInfoDto {
  UserInfoDto(this.email, this.login, this.role, this.isBlocked,
      this.numberOfCreatedGuides);
  final String email;
  final String login;
  //final DateTime birthday;
  final String role;
  final bool isBlocked;
  final int numberOfCreatedGuides;

  factory UserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDtoFromJson(json);
}
