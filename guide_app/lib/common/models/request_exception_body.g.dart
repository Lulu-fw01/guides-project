// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_exception_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestExceptionBody _$RequestExceptionBodyFromJson(
        Map<String, dynamic> json) =>
    RequestExceptionBody(
      json['timestamp'] as String,
      json['status'] as int,
      json['error'] as String,
      json['message'] as String,
      json['path'] as String,
    );

Map<String, dynamic> _$RequestExceptionBodyToJson(
        RequestExceptionBody instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'path': instance.path,
    };
