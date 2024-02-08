
import 'package:json_annotation/json_annotation.dart';

part 'request_login_model.g.dart';

@JsonSerializable()
class RequestLoginModel {
  final String email;
  final String password;

  RequestLoginModel({
    required this.email,
    required this.password,
  });

  factory RequestLoginModel.fromJson(Map<String, dynamic> json) => _$RequestLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLoginModelToJson(this);
}