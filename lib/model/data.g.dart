// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoData _$TodoDataFromJson(Map<String, dynamic> json) => TodoData(
  id: json['id'] as String?,
  isCompleted: json['isCompleted'] as bool?,
  title: json['title'] as String?,
  note: json['note'] as String?,
  date: json['date'] as String?,
  startTime: json['startTime'] as String?,
  endTime: json['endTime'] as String?,
  reminders: (json['reminders'] as num?)?.toInt(),
  repeat: json['repeat'] as String?,
  colors: (json['colors'] as num?)?.toInt(),
);

Map<String, dynamic> _$TodoDataToJson(TodoData instance) => <String, dynamic>{
  'id': instance.id,
  'isCompleted': instance.isCompleted,
  'title': instance.title,
  'note': instance.note,
  'date': instance.date,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'reminders': instance.reminders,
  'repeat': instance.repeat,
  'colors': instance.colors,
};
