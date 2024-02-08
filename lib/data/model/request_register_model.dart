import 'package:json_annotation/json_annotation.dart';

part 'request_register_model.g.dart';

@JsonSerializable()
class RequestRegisterModel {
  final String nickname;
  final String sex;
  final String birth_date;
  final bool privateYN;
  final String email;
  final String password;

  RequestRegisterModel({
    required this.nickname,
    required this.sex,
    required this.birth_date,
    required this.privateYN,
    required this.email,
    required this.password
  });

  factory RequestRegisterModel.fromJson(Map<String, dynamic> json) => _$RequestRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestRegisterModelToJson(this);
}