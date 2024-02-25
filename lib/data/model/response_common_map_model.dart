import 'package:json_annotation/json_annotation.dart';

part 'response_common_map_model.g.dart';

@JsonSerializable()
class ResponseCommonMapModel {
  final int code;
  final String message;
  final Map<String, dynamic> data;

  ResponseCommonMapModel({
    required this.code,
    required this.message,
    required this.data
  });

  factory ResponseCommonMapModel.fromJson(Map<String, dynamic> json) => _$ResponseCommonMapModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCommonMapModelToJson(this);
} 