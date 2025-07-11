import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/data.dart';
import 'package:to_do_app/providers/TodoProvider.dart';

class EditTodo extends StatefulWidget {
  final String todoId;

  const EditTodo({super.key, required this.todoId});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  late TextEditingController _title;
  late TextEditingController _note;
  String? _repeat;
  int? reminder;
  String? startTime;
  String? endTime;
  bool isEditing = false;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      final todo = todoProvider.getById(widget.todoId);

      if (todo != null) {
        _title = TextEditingController(text: todo.title ?? '');
        _note = TextEditingController(text: todo.note ?? '');
        _repeat = todo.repeat;
        reminder = todo.reminders;
        startTime = todo.startTime;
        endTime = todo.endTime;
      }
      isInitialized = true;
    }
  }

  void SaveChanges(TodoProvider provider, TodoData original) {
    print('[DEBUG] SaveChanges dipanggil');
    if (original != null) {
      final updated = original.copyWith(
        id: original.id,
        title: _title.text,
        note: _note.text,
        repeat: _repeat ?? original.repeat,
        reminders: reminder ?? original.reminders,
        startTime: startTime ?? original.startTime,
        endTime: endTime ?? original.endTime,
        colors: original.colors,
        isCompleted: original.isCompleted,
        date: original.date,
      );
      print('[DEBUG] Data sebelum update: ${original.toJson()}');
      print('[DEBUG] Data setelah update: ${updated.toJson()}');
      provider.updateTodo(updated);
    } else {
      print('[DEBUG] Todo tidak ditemukan');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('To do Not Found')));
    }
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todo = todoProvider.getById(widget.todoId);
    if (todo == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Edit Todo')),
        body: Center(child: Text('Todo not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (isEditing) {
                SaveChanges(todoProvider, todo);
              }
              toggleEdit();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _title,
              enabled: isEditing,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              enabled: isEditing,
              decoration: InputDecoration(labelText: 'Catatan'),
            ),
            const SizedBox(height: 12),
            // Field tambahan (optional)
            // Repeat, Reminder, StartTime, EndTime, dll
          ],
        ),
      ),
    );
  }
}
