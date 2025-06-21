import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/components/Completed.dart';
import 'package:to_do_app/components/Todo.dart';

enum Status { Todo, Completed }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Status StatusAt = Status.Todo;

  String get formattedDate => DateFormat('EEE, d MMM ').format(_selectedDate);

  Future<void> _pickDate(BuildContext context) async {
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: 'Todo',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
              children: const <TextSpan>[
                TextSpan(
                  text: 'List',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                title: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                ),
                trailing: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    formattedDate,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),

                TextButton.icon(
                  onPressed: () => _pickDate(context),
                  icon: Icon(
                    Icons.calendar_month,
                    size: 20,
                    color: Colors.blueAccent,
                  ),
                  label: Text('Date'),
                ),
                const SizedBox(height: 20),
              ],
            ),
            SizedBox(height: 30),
            SegmentedButton<Status>(
              segments: const <ButtonSegment<Status>>[
                ButtonSegment<Status>(value: Status.Todo, label: Text('todo')),
                ButtonSegment<Status>(
                  value: Status.Completed,
                  label: Text('completed'),
                ),
              ],
              selected: <Status>{StatusAt},
              onSelectionChanged: (Set<Status> newStatus) {
                setState(() {
                  StatusAt = newStatus.first;
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(child: StatusAt == Status.Todo ? Todo() : Completed()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Floating Button Clicked')));
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
