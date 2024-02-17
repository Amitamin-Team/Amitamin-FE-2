// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_logout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestLogoutModel _$RequestLogoutModelFromJson(Map<String, dynamic> json) =>
    RequestLogoutModel(
      email: json['email'] as String,
      password: json['password'] as String,
      access_token: json['access_token'] as String,
    );

Map<String, dynamic> _$RequestLogoutModelToJson(RequestLogoutModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'access_token': instance.access_token,
    };
