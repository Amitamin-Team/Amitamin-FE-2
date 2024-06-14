
import 'package:json_annotation/json_annotation.dart';

part 'response_login_user_model.g.dart';

@JsonSerializable()
class ResponseLoginUserModel {
  final int id;
  final String nickname;
  final String email;

  ResponseLoginUserModel({
    required this.id,
    required this.nickname,
    required this.email,
  });

  factory ResponseLoginUserModel.fromJson(Map<String, dynamic> json) => _$ResponseLoginUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginUserModelToJson(this);
}