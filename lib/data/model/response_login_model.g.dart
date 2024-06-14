// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLoginModel _$ResponseLoginModelFromJson(Map<String, dynamic> json) =>
    ResponseLoginModel(
      access_token: json['access_token'] as String,
      token_type: json['token_type'] as String,
      expires_in: json['expires_in'] as int,
      refresh_token: json['refresh_token'] as String,
      user: json['user'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ResponseLoginModelToJson(ResponseLoginModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'refresh_token': instance.refresh_token,
      'user': instance.user,
    };
