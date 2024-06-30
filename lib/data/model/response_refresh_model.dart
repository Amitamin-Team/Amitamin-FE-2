
import 'package:json_annotation/json_annotation.dart';

part 'response_refresh_model.g.dart';

@JsonSerializable()
class ResponseRefreshModel {
  final String access_token;
  final String token_type;
  final int expires_in;
  final String refresh_token;
  final Map<String, dynamic> user;

  ResponseRefreshModel({
    required this.access_token,
    required this.token_type,
    required this.expires_in,
    required this.refresh_token,
    required this.user,
  });

  factory ResponseRefreshModel.fromJson(Map<String, dynamic> json) => _$ResponseRefreshModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRefreshModelToJson(this);
}