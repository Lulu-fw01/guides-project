import 'package:json_annotation/json_annotation.dart';

part 'sign_up_dto.g.dart';

/// Sign up dto.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class SignUpDto {
  SignUpDto(this.login, this.email, this.password);
  final String login;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$SignUpDtoToJson(this);
}
