// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_login_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLoginUserModel _$ResponseLoginUserModelFromJson(
        Map<String, dynamic> json) =>
    ResponseLoginUserModel(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ResponseLoginUserModelToJson(
        ResponseLoginUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'email': instance.email,
    };
