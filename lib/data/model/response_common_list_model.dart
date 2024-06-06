import 'package:json_annotation/json_annotation.dart';

part 'response_common_list_model.g.dart';

@JsonSerializable()
class ResponseCommonListModel {
  final int response_code;
  final String response_message;
  final List<dynamic>? data;

  ResponseCommonListModel({
    required this.response_code,
    required this.response_message,
    this.data
  });

  factory ResponseCommonListModel.fromJson(Map<String, dynamic> json) => _$ResponseCommonListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCommonListModelToJson(this);
} 