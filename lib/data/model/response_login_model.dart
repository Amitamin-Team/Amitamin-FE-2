
import 'package:json_annotation/json_annotation.dart';

part 'response_login_model.g.dart';

@JsonSerializable()
class ResponseLoginModel {
  final String access_token;
  final String token_type;
  final int expires_in;
  final String refresh_token;
  final Map<String, dynamic> user;

  ResponseLoginModel({
    required this.access_token,
    required this.token_type,
    required this.expires_in,
    required this.refresh_token,
    required this.user,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) => _$ResponseLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginModelToJson(this);
}