// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_common_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCommonMapModel _$ResponseCommonMapModelFromJson(
        Map<String, dynamic> json) =>
    ResponseCommonMapModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ResponseCommonMapModelToJson(
        ResponseCommonMapModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
