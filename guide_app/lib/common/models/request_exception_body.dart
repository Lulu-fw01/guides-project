@JsonSerializable()
class RequestExceptionBody {
RequestExceptionBody(this.timestamp, this.status, this.error, this.message, this.path);
String timestamp;
int status;
String error;
String message;
String path;
Map<String, dynamic> toJson() => _$AuthDtoToJson(this);
}


// TODO handle {"timestamp":"2023-02-03T23:24:37.352+00:00","status":400,"error":"Bad Request","message":"The user already exists","path":"/api/v1/auth/sign-up"}
