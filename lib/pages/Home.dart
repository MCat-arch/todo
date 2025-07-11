import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/components/Completed.dart';
import 'package:to_do_app/components/Todo.dart';
import 'package:to_do_app/providers/ThemeProvider.dart';
import 'package:to_do_app/components/InputForm.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/TodoProvider.dart';
import 'package:to_do_app/pages/ProfileScreen.dart';
import 'package:to_do_app/service/notification_todo.dart';

enum Status { Todo, Completed }

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;
  late NotifyHelper notifyHelper;
  Timer? _autoCompleteTimer;

  List<Widget> widgetOptions = const [Home(), ProfileScreen()];

  void onTimeTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startAutoChecker() {
    _autoCompleteTimer = Timer.periodic(Duration(minutes: 1), (_) {
      Provider.of<TodoProvider>(context, listen: false).autoCompleteTask();
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoChecker();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  @override
  void dispose() {
    _autoCompleteTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF5EC),
      appBar:
          _selectedIndex == 0
              ? AppBar(
                // backgroundColor: Colors.black,
                toolbarHeight: 100,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Todo',
                      style: TextStyle(
                        fontSize: 42,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'List',
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
              )
              : null,
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.white60,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: onTimeTapped,
      ),
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  // ScaffoldMessenger.of(
                  //   context,
                  // ).showSnackBar(SnackBar(content: Text('Floating Button Clicked')));
                  context.push('/InputForm');
                  // Navigator.push(context, InputForm());
                },
                backgroundColor: Colors.blueAccent,
                // shape: ShapeBorder.lerp(a, b, t),
                child: Icon(Icons.add, color: Colors.white),
              )
              : null,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Status StatusAt = Status.Todo;
  bool isDarkMode = false;

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
    final int todoCount = context.select<TodoProvider, int>(
      (p) => p.todos.length,
    );
    final int completedCount = context.select<TodoProvider, int>(
      (p) => p.completed.length,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Expanded(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // borderRadius: BorderRadius.circular(15),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color.fromARGB(255, 65, 65, 65)),
            ),
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
          // ),
          //     SizedBox(width: 10),
          //     Expanded(
          //       child: SwitchListTile(
          //         value: Provider.of<ThemeProvider>(context).isDarkMode,
          //         onChanged: (_) {
          //           Provider.of<ThemeProvider>(
          //             context,
          //             listen: false,
          //           ).toggleTheme();
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  DateFormat('EEEE, d MMMM').format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              TextButton.icon(
                onPressed: () => _pickDate(context),
                icon: Icon(
                  Icons.calendar_month,
                  size: 37,
                  color: const Color.fromARGB(255, 62, 62, 62),
                ),
                label: Text(''),
              ),
              const SizedBox(height: 20),
            ],
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade400, width: 1.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        StatusAt = Status.Todo;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'To Do',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                StatusAt == Status.Todo
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                StatusAt == Status.Todo
                                    ? Colors.black
                                    : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            todoCount
                                .toString(), // TODO: Replace with actual count
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        StatusAt = Status.Completed;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                StatusAt == Status.Completed
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                StatusAt == Status.Completed
                                    ? Colors.black
                                    : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            completedCount
                                .toString(), // TODO: Replace with actual completed count
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // SegmentedButton<Status>(
          //   segments: const <ButtonSegment<Status>>[
          //     ButtonSegment<Status>(value: Status.Todo, label: Text('todo')),
          //     ButtonSegment<Status>(

          //       value: Status.Completed,
          //       label: Text('completed'),
          //     ),
          //   ],
          //   selected: <Status>{StatusAt},
          //   onSelectionChanged: (Set<Status> newStatus) {
          //     setState(() {
          //       StatusAt = newStatus.first;
          //     });
          //   },
          // ),
          SizedBox(height: 20),
          Expanded(child: StatusAt == Status.Todo ? Todo() : Completed()),
        ],
      ),
    );
  }
}
