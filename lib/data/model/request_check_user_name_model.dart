
import 'package:json_annotation/json_annotation.dart';

part 'request_check_user_name_model.g.dart';

@JsonSerializable()
class RequestCheckUserNameModel {
  final String nickname;

  RequestCheckUserNameModel({
    required this.nickname
  });

  factory RequestCheckUserNameModel.fromJson(Map<String, dynamic> json) => _$RequestCheckUserNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCheckUserNameModelToJson(this);
}