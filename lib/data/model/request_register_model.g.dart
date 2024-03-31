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
      birth: json['birth'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      private_yn: json['private_yn'] as String,
      survey_summary: json['survey_summary'] as String,
    );

Map<String, dynamic> _$RequestRegisterModelToJson(
        RequestRegisterModel instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'sex': instance.sex,
      'birth': instance.birth,
      'email': instance.email,
      'password': instance.password,
      'private_yn': instance.private_yn,
      'survey_summary': instance.survey_summary,
    };
