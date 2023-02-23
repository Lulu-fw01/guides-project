import 'package:json_annotation/json_annotation.dart';

part 'response_exception_body.g.dart';

/// Http request exception model.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs .
@JsonSerializable()
class ResponseExceptionBody {
  ResponseExceptionBody(
      this.timestamp, this.status, this.error, this.message, this.path);
  String timestamp;

  /// Error status.
  int status;
  String error;

  /// Error message
  String message;
  String path;
  factory ResponseExceptionBody.fromJson(Map<String, dynamic> json) =>
      _$ResponseExceptionBodyFromJson(json);
}
