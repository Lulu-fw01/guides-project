// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_exception_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseExceptionBody _$ResponseExceptionBodyFromJson(
        Map<String, dynamic> json) =>
    ResponseExceptionBody(
      json['timestamp'] as String,
      json['status'] as int,
      json['error'] as String,
      json['message'] as String,
      json['path'] as String,
    );

Map<String, dynamic> _$ResponseExceptionBodyToJson(
        ResponseExceptionBody instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'path': instance.path,
    };
