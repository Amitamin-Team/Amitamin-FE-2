import 'package:json_annotation/json_annotation.dart';

part 'response_common_list_model.g.dart';

@JsonSerializable()
class ResponseCommonListModel {
  final int code;
  final String message;
  final List<dynamic> data;

  ResponseCommonListModel({
    required this.code,
    required this.message,
    required this.data
  });

  factory ResponseCommonListModel.fromJson(Map<String, dynamic> json) => _$ResponseCommonListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCommonListModelToJson(this);
} 