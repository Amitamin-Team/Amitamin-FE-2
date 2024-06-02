// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRegisterModel _$RequestRegisterModelFromJson(
        Map<String, dynamic> json) =>
    RequestRegisterModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String?,
      nickname: json['nickname'] as String,
      sex: json['sex'] as String,
      birth: json['birth'] as String,
      user_age: json['user_age'] as int?,
      private_yn: json['private_yn'] as String,
      phone_num: json['phone_num'] as String?,
      mobile_carrier: json['mobile_carrier'] as String?,
      push_key: json['push_key'] as String?,
      user_type_code: json['user_type_code'] as int?,
      user_del_fg: json['user_del_fg'] as String?,
      survey_summary: json['survey_summary'] as String,
    );

Map<String, dynamic> _$RequestRegisterModelToJson(
        RequestRegisterModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'nickname': instance.nickname,
      'sex': instance.sex,
      'birth': instance.birth,
      'user_age': instance.user_age,
      'private_yn': instance.private_yn,
      'phone_num': instance.phone_num,
      'mobile_carrier': instance.mobile_carrier,
      'push_key': instance.push_key,
      'user_type_code': instance.user_type_code,
      'user_del_fg': instance.user_del_fg,
      'survey_summary': instance.survey_summary,
    };
