import 'package:json_annotation/json_annotation.dart';

part 'auth_dto.g.dart';

/// Authentication dto.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class AuthDto {
  AuthDto(this.email, this.password);
  String email;
  String password;

  Map<String, dynamic> toJson() => _$AuthDtoToJson(this);
}
