import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/service/notification_todo.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoData> _todos = [];

  String _todoKey = 'todo_data';

  List<TodoData> get todos =>
      _todos.where((t) => t.isCompleted != true).toList();
  List<TodoData> get completed =>
      _todos.where((t) => t.isCompleted == true).toList();

  TodoProvider() {
    initialState();
  }

  Future initialState() async {
    await loadData();
    notifyListeners();
  }

  Future loadData() async {
    final _prefs = await SharedPreferences.getInstance();
    final todoDataJson = _prefs.getString(_todoKey) ?? '[]';

    final List<dynamic> jsonList = jsonDecode(todoDataJson);
    _todos = jsonList.map((data) => TodoData.fromJson(data)).toList();
  }

  Future<void> addTodo(TodoData data) async {
    _todos.add(data);
    await saveTodo();
    notifyListeners();
  }

  Future<void> saveTodo() async {
    final _prefs = await SharedPreferences.getInstance();
    final toJson = jsonEncode(_todos.map((d) => d.toJson()).toList());
    await _prefs.setString(_todoKey, toJson);
  }

  Future updateTodo(TodoData data) async {
    final i = _todos.indexWhere((d) => d.id == data.id);
    if (i >= 0) {
      _todos[i] = data;
      await saveTodo();
      notifyListeners();
    }
  }

  Future deleteData(int id) async {
    _todos.removeWhere((d) => d.id == id);
    await saveTodo();
    notifyListeners();
  }

  Future markCompleted(String id) async {
    final i = _todos.indexWhere((d) => d.id == id);
    if (i != -1) {
      _todos[i].isCompleted = true;
      await saveTodo();
      notifyListeners();
    }
  }

  TodoData? getById(String id) {
    try {
      return _todos.firstWhere((i) => i.id == id);
    } catch (e) {
      return null;
    }
  }

  Future autoCompleteTask() async {
    final now = DateTime.now();

    for (var task in _todos) {
      if (task.isCompleted == true) continue;
      try {
        final time = DateFormat('yyyy-MM-dd').parse(task.date!);
        final timeParts = task.endTime!.split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);
        final endDateTime = DateTime(
          time.year,
          time.month,
          time.day,
          hour,
          minute,
        );
        if (endDateTime.isBefore(now)) {
          task.isCompleted = true;
          await updateTodo(task);
          await NotifyHelper().cancelNotification(task);
        }
      } catch (e) {
        print('Parsing error: $e');
      }
    }

    // notifyListeners();
  }
}
