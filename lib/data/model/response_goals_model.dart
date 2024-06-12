import 'package:json_annotation/json_annotation.dart';

part 'response_goals_model.g.dart';

@JsonSerializable()
class ResponseGoalsModel {
  final int goal_id;
  final int user_id;
  final int goal_type_code;
  final String goal_name;
  final String start_dt;
  final String end_dt;
  final String alarm_fg;
  final String alarm_time;
  final int goal_day;
  final int goal_code;
  final String goal_del_fg;
  final String created_at;
  final String updated_at;

  ResponseGoalsModel({
    required this.goal_id,
    required this.user_id,
    required this.goal_type_code,
    required this.goal_name,
    required this.start_dt,
    required this.end_dt,
    required this.alarm_fg,
    required this.alarm_time,
    required this.goal_day,
    required this.goal_code,
    required this.goal_del_fg,
    required this.created_at,
    required this.updated_at
  });

  factory ResponseGoalsModel.fromJson(Map<String, dynamic> json) => _$ResponseGoalsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGoalsModelToJson(this);
} 