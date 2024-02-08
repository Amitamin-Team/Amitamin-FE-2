// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRegisterModel _$ResponseRegisterModelFromJson(
        Map<String, dynamic> json) =>
    ResponseRegisterModel(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ResponseRegisterModelToJson(
        ResponseRegisterModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };
