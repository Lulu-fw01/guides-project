// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoDto _$UserInfoDtoFromJson(Map<String, dynamic> json) => UserInfoDto(
      json['email'] as String,
      json['login'] as String,
      DateTime.parse(json['birthday'] as String),
      json['role'] as String,
      json['isBlocked'] as bool,
    );

Map<String, dynamic> _$UserInfoDtoToJson(UserInfoDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'login': instance.login,
      'birthday': instance.birthday.toIso8601String(),
      'role': instance.role,
      'isBlocked': instance.isBlocked,
    };
