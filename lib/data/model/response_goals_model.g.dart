// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_goals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGoalsModel _$ResponseGoalsModelFromJson(Map<String, dynamic> json) =>
    ResponseGoalsModel(
      goal_id: json['goal_id'] as int,
      user_id: json['user_id'] as int,
      goal_type_code: json['goal_type_code'] as int,
      goal_name: json['goal_name'] as String,
      start_dt: json['start_dt'] as String,
      end_dt: json['end_dt'] as String,
      alarm_fg: json['alarm_fg'] as String,
      alarm_time: json['alarm_time'] as String,
      goal_day: json['goal_day'] as int,
      goal_code: json['goal_code'] as int,
      goal_del_fg: json['goal_del_fg'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$ResponseGoalsModelToJson(ResponseGoalsModel instance) =>
    <String, dynamic>{
      'goal_id': instance.goal_id,
      'user_id': instance.user_id,
      'goal_type_code': instance.goal_type_code,
      'goal_name': instance.goal_name,
      'start_dt': instance.start_dt,
      'end_dt': instance.end_dt,
      'alarm_fg': instance.alarm_fg,
      'alarm_time': instance.alarm_time,
      'goal_day': instance.goal_day,
      'goal_code': instance.goal_code,
      'goal_del_fg': instance.goal_del_fg,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
