// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_common_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCommonListModel _$ResponseCommonListModelFromJson(
        Map<String, dynamic> json) =>
    ResponseCommonListModel(
      response_code: json['response_code'] as int,
      response_message: json['response_message'] as String,
      data: json['data'] as List<dynamic>,
    );

Map<String, dynamic> _$ResponseCommonListModelToJson(
        ResponseCommonListModel instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'response_message': instance.response_message,
      'data': instance.data,
    };
