import 'package:json_annotation/json_annotation.dart';

part 'request_register_model.g.dart';

@JsonSerializable()
class RequestRegisterModel {
  final String email;
  final String password;
  final String? name;
  final String nickname;
  final String sex;
  final String birth;
  final int? user_age;
  final String private_yn;
  final String? phone_num;
  final String? mobile_carrier;
  final String? push_key;
  final int? user_type_code;
  final String? user_del_fg;
  final String survey_summary;

  RequestRegisterModel({
    required this.email,
    required this.password,
    this.name,
    required this.nickname,
    required this.sex,
    required this.birth,
    this.user_age,
    required this.private_yn,
    this.phone_num,
    this.mobile_carrier,
    this.push_key,
    this.user_type_code,
    this.user_del_fg,
    required this.survey_summary
  });

  factory RequestRegisterModel.fromJson(Map<String, dynamic> json) => _$RequestRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestRegisterModelToJson(this);
}