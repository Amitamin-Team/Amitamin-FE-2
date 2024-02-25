// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_common_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCommonListModel _$ResponseCommonListModelFromJson(
        Map<String, dynamic> json) =>
    ResponseCommonListModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as List<dynamic>,
    );

Map<String, dynamic> _$ResponseCommonListModelToJson(
        ResponseCommonListModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
