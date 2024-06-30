// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_refresh_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRefreshModel _$ResponseRefreshModelFromJson(
        Map<String, dynamic> json) =>
    ResponseRefreshModel(
      access_token: json['access_token'] as String,
      token_type: json['token_type'] as String,
      expires_in: json['expires_in'] as int,
      refresh_token: json['refresh_token'] as String,
      user: json['user'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ResponseRefreshModelToJson(
        ResponseRefreshModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'refresh_token': instance.refresh_token,
      'user': instance.user,
    };
