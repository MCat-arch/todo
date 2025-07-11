import 'dart:convert';
import 'package:to_do_app/model/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todocontroller {
  static SharedPreferences? prefs;
  final _todoKey = 'todo_data';

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // final todoDataMap = jsonDecode(jsonString) as Map<String, dynamic>;
  // final todoData = TodoData.fromJson(todoDataMap);

  Future<List<TodoData>> getTodoData() async {
    final todoDataJson = prefs?.getString(_todoKey) ?? '[]';
    final todoDataList = jsonDecode(todoDataJson) as List<dynamic>;
    return todoDataList.map((json) => TodoData.fromJson(json)).toList();
  }

  Future addTodoData(TodoData data) async {
    final allData = await getTodoData();
    allData.add(data); // Add new data to the list
    final toJson = jsonEncode(allData);
    return prefs?.setString(_todoKey, toJson);
  }

  Future updateData(TodoData data) async {
    final allData = await getTodoData();
    final i = allData.indexWhere((d) => d.id == data.id);
    if (i >= 0) {
      allData[i] = data;
      final toJson = jsonEncode(allData);
      return prefs?.setString(_todoKey, toJson);
    }
  }

  Future deleteData(int id) async {
    final allData = await getTodoData();
    allData.removeWhere((d) => d.id == id);
    final toJson = jsonEncode(allData);
    return prefs?.setString(_todoKey, toJson);
  }

  Future isCompleted(int id) async {
    final allData = await getTodoData();
    if (allData.isEmpty) {
      return false;
    } else if (allData.length >= 0) {
      final todo = allData.firstWhere((d) => d.id == id);
      return todo.isCompleted ?? false;
    } else {
      throw Exception('Data not found');
    }
  }
}
