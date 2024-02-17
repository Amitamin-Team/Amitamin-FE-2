
import 'package:json_annotation/json_annotation.dart';

part 'request_check_verification_code_model.g.dart';

@JsonSerializable()
class RequestCheckVerificationCodeModel {
  final String token;

  RequestCheckVerificationCodeModel({
    required this.token
  });

  factory RequestCheckVerificationCodeModel.fromJson(Map<String, dynamic> json) => _$RequestCheckVerificationCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCheckVerificationCodeModelToJson(this);
}