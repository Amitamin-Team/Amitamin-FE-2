
import 'package:json_annotation/json_annotation.dart';

part 'request_logout_model.g.dart';

@JsonSerializable()
class RequestLogoutModel {
  final String email;

  RequestLogoutModel({
    required this.email,
  });

  factory RequestLogoutModel.fromJson(Map<String, dynamic> json) => _$RequestLogoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLogoutModelToJson(this);
}