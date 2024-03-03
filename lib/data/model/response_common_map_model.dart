import 'package:json_annotation/json_annotation.dart';

part 'response_common_map_model.g.dart';

@JsonSerializable()
class ResponseCommonMapModel {
  final int response_code;
  final String response_message;
  final Map<String, dynamic> data;

  ResponseCommonMapModel({
    required this.response_code,
    required this.response_message,
    required this.data
  });

  factory ResponseCommonMapModel.fromJson(Map<String, dynamic> json) => _$ResponseCommonMapModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCommonMapModelToJson(this);
} 