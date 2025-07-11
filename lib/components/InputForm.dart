import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/model/data.dart';
import 'package:to_do_app/pages/Home.dart';
import 'package:to_do_app/providers/TodoProvider.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

final uuid = Uuid();

class Inputform extends StatefulWidget {
  const Inputform({super.key});

  @override
  State<Inputform> createState() => _InputformState();
}

class _InputformState extends State<Inputform> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool isCompleted = false;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int _reminder = 10;
  String _repeat = 'tidak ada';
  final List<Color> _colorOptions = [Colors.blue, Colors.red, Colors.orange];
  int _selectedColorIndex = 0;

  String get formattedDate => DateFormat('EEE, d MMM ').format(_selectedDate);

  Future<void> _pickTime(BuildContext context, {required bool isStart}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          isStart
              ? (_startTime ?? TimeOfDay.now())
              : (_endTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void onAdd() {
    TodoData newData = TodoData(
      id: uuid.v4(),
      isCompleted: isCompleted,
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat('yyyy-MM-dd').format(_selectedDate),
      startTime:
          _startTime != null
              ? '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}'
              : '',
      endTime:
          _endTime != null
              ? '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}'
              : '',
      reminders: _reminder,
      repeat: _repeat,
      colors: _selectedColorIndex,
    );

    Provider.of<TodoProvider>(context, listen: false).addTodo(newData);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //add icon to close from the input form
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          toolbarHeight: 100,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Add',
                      style: TextStyle(
                        fontSize: 42,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: ' Todo',
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 48),
            ],
          ),
        ),
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Note',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    hintStyle: TextStyle(color: Colors.grey.shade600),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                // Date Picker ListTile
                ListTile(
                  style: ListTileStyle.drawer,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Text(
                    formattedDate,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      color: const Color.fromARGB(255, 68, 68, 68),
                      size: 30,
                    ),
                    label: Text(''),
                  ),
                ),
                SizedBox(height: 10),
                // Start Time & End Time Row
                Text(
                  'Select Time',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),

                          labelText: "Start Time",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: const Color.fromARGB(255, 39, 39, 39),
                          ),
                        ),
                        controller: TextEditingController(
                          text:
                              _startTime != null
                                  ? _startTime!.format(context)
                                  : '',
                        ),
                        onTap: () => _pickTime(context, isStart: true),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),

                          labelText: "End Time",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: const Color.fromARGB(255, 39, 39, 39),
                          ),
                        ),
                        controller: TextEditingController(
                          text:
                              _endTime != null ? _endTime!.format(context) : '',
                        ),
                        onTap: () => _pickTime(context, isStart: false),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Dropdown Reminder
                // Reminder & Repeat dalam satu baris responsif
                Text(
                  'Reminder',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),

                          // labelText: "Reminder",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        value: _reminder,
                        items:
                            [5, 10, 15, 30, 60]
                                .map(
                                  (min) => DropdownMenuItem(
                                    value: min,
                                    child: Text("$min menit sebelum"),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _reminder = val;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Repeat',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),

                          // labelText: "Repeat",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        value: _repeat,
                        items:
                            [
                                  'tidak ada',
                                  '3 jam sekali',
                                  'setiap hari',
                                  'setiap minggu',
                                ]
                                .map(
                                  (str) => DropdownMenuItem(
                                    value: str,
                                    child: Text(str),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _repeat = val;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                // Baris warna dan tombol Save responsif
                Row(
                  children: [
                    Row(
                      children: List.generate(_colorOptions.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColorIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      _selectedColorIndex == index
                                          ? Colors.black
                                          : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: _colorOptions[index],
                                radius: 15,
                                child:
                                    _selectedColorIndex == index
                                        ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                        : null,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    // SizedBox(width: 16),
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: onAdd,
                    //     child: Text('Save'),
                    //   ),
                    // ),
                  ],
                ),
                // ...existing code...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
