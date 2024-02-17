
import 'package:json_annotation/json_annotation.dart';

part 'request_logout_model.g.dart';

@JsonSerializable()
class RequestLogoutModel {
  final String email;
  final String password;
  final String access_token;

  RequestLogoutModel({
    required this.email,
    required this.password,
    required this.access_token
  });

  factory RequestLogoutModel.fromJson(Map<String, dynamic> json) => _$RequestLogoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLogoutModelToJson(this);
}