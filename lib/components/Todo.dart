import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/TodoProvider.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  String formatTime(String? time) {
    if (time == null) return '';
  try {
    final parsed = DateFormat('HH:mm').parse(time);
    return DateFormat.Hm().format(parsed); // returns HH:mm
  } catch (e) {
    return '';
  }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> _colorOptions = [Colors.blue, Colors.red, Colors.orange];
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final todos = todoProvider.todos;
        if (todos.isEmpty) {
          return Center(child: Text('No todo found'));
        }
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return GestureDetector(
              onTap: () {
                context.push('/EditTodo', extra: todo.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _colorOptions[todo.colors ?? 0],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),

                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            todo.note!,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.black,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '${formatTime(todo.startTime)} - ${formatTime(todo.endTime)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: 2,
                      height: 100,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    RotatedBox(
                      quarterTurns: 3, // 180 derajat
                      child: Text(
                        'Todo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
