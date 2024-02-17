
import 'package:json_annotation/json_annotation.dart';

part 'request_send_verification_code_model.g.dart';

@JsonSerializable()
class RequestSendVerificationCodeModel {
  final String email;

  RequestSendVerificationCodeModel({
    required this.email
  });

  factory RequestSendVerificationCodeModel.fromJson(Map<String, dynamic> json) => _$RequestSendVerificationCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSendVerificationCodeModelToJson(this);
}