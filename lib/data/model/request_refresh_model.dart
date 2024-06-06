
import 'package:json_annotation/json_annotation.dart';

part 'request_refresh_model.g.dart';

@JsonSerializable()
class RequestRefreshModel {
  final String refresh_token;

  RequestRefreshModel({
    required this.refresh_token,
  });

  factory RequestRefreshModel.fromJson(Map<String, dynamic> json) => _$RequestRefreshModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestRefreshModelToJson(this);
}