import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Inputform extends StatefulWidget {
  const Inputform({super.key});

  @override
  State<Inputform> createState() => _InputformState();
}

class _InputformState extends State<Inputform> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int _reminder = 10;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 219, 244, 255),
        title: RichText(
          text: TextSpan(
            text: 'Add',
            style: TextStyle(
              fontSize: 30,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w600,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: 'Task',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 5, 67, 255),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20),
            // Date Picker ListTile
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                formattedDate,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                icon: Icon(Icons.edit_calendar, color: Colors.blueAccent),
                label: Text('Pilih'),
              ),
            ),
            // Start Time & End Time Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Start Time",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: Icon(
                        Icons.access_time,
                        color: Colors.blueAccent,
                      ),
                    ),
                    controller: TextEditingController(
                      text:
                          _startTime != null ? _startTime!.format(context) : '',
                    ),
                    onTap: () => _pickTime(context, isStart: true),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "End Time",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: Icon(
                        Icons.access_time,
                        color: Colors.blueAccent,
                      ),
                    ),
                    controller: TextEditingController(
                      text: _endTime != null ? _endTime!.format(context) : '',
                    ),
                    onTap: () => _pickTime(context, isStart: false),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Dropdown Reminder
            Row(
              children: [
                SizedBox(width: 10),
                Text("Reminder:"),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
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
          ],
        ),
      ),
    );
  }
}
