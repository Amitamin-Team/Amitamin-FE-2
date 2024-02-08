import 'package:json_annotation/json_annotation.dart';

part 'response_register_model.g.dart';

@JsonSerializable()
class ResponseRegisterModel {
  final int code;
  final String message;
  final bool success;
  final Map<String, dynamic> data;

  ResponseRegisterModel({
    required this.code,
    required this.message,
    required this.success,
    required this.data
  });

  factory ResponseRegisterModel.fromJson(Map<String, dynamic> json) => _$ResponseRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRegisterModelToJson(this);
}