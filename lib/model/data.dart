import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
//untuk membuat json dari kelas tododata
class TodoData {
  final String? id;
   bool? isCompleted;
  final String? title;
  final String? note;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? reminders;
  final String? repeat;
  final int? colors;

  TodoData({
    required this.id,
    required this.isCompleted,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminders,
    required this.repeat,
    required this.colors,
  });

  //json serialization
  // CARA MANUAL

  // Map<String, dynamic> toJson(){
  //   return {
  //     'id': id,
  //     'isCompleted': isCompleted,
  //     'title': title,
  //     'note': note,
  //     'date': date,
  //     'startTime': startTime,
  //     'endTime': endTime,
  //     'reminders': reminders,
  //     'repeat': repeat,
  //     'colors': colors,
  //   };
  // }

  // TodoData.fromJson(Map<String, dynamic> json){
  //   id = json['id'];
  //   isCompleted = json['isCompleted'];
  //   title = json['title'];
  //   note = json['note'];
  //   date = json['date'];
  //   startTime = json['startTime'];
  //   endTime = json['endTime'];
  //   reminders = json['reminders'];
  //   repeat = json['repeat'];
  //   colors = json['colors'];
  // }

  //Copy With
  TodoData copyWith({
    String? id,
    bool? isCompleted,
    String? title,
    String? note,
    String? date,
    String? startTime,
    String? endTime,
    int? reminders,
    String? repeat,
    int? colors,
  }) {
    return TodoData(
      id: id,
      isCompleted: isCompleted,
      title: title,
      note: note,
      date: date,
      startTime: startTime,
      endTime: endTime,
      reminders: reminders,
      repeat: repeat,
      colors: colors,
    );
  }

  // CARA AUTO
  factory TodoData.fromJson(Map<String, dynamic> json) =>
      _$TodoDataFromJson(json);
  Map<String, dynamic> toJson() => _$TodoDataToJson(this);
}
