// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_common_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCommonMapModel _$ResponseCommonMapModelFromJson(
        Map<String, dynamic> json) =>
    ResponseCommonMapModel(
      response_code: json['response_code'] as int,
      response_message: json['response_message'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ResponseCommonMapModelToJson(
        ResponseCommonMapModel instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'response_message': instance.response_message,
      'data': instance.data,
    };
