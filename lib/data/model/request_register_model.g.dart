// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRegisterModel _$RequestRegisterModelFromJson(
        Map<String, dynamic> json) =>
    RequestRegisterModel(
      nickname: json['nickname'] as String,
      sex: json['sex'] as String,
      birth_date: json['birth_date'] as String,
      privateYN: json['privateYN'] as bool,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RequestRegisterModelToJson(
        RequestRegisterModel instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'sex': instance.sex,
      'birth_date': instance.birth_date,
      'privateYN': instance.privateYN,
      'email': instance.email,
      'password': instance.password,
    };
