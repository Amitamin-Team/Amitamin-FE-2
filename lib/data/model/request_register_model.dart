import 'package:json_annotation/json_annotation.dart';

part 'request_register_model.g.dart';

@JsonSerializable()
class RequestRegisterModel {
  final String nickname;
  final String sex;
  final String birth;
  final String email;
  final String password;
  final String private_yn;
  final String survey_summary;

  RequestRegisterModel({
    required this.nickname,
    required this.sex,
    required this.birth,
    required this.email,
    required this.password,
    required this.private_yn,
    required this.survey_summary
  });

  factory RequestRegisterModel.fromJson(Map<String, dynamic> json) => _$RequestRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestRegisterModelToJson(this);
}