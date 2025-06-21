import 'package:flutter/material.dart';
import 'package:to_do_app/components/InputForm.dart';
import 'package:to_do_app/example/Snackbar.dart';
import 'pages/Home.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF1E3A8A), // Navy blue
        scaffoldBackgroundColor: const Color(0xFFF1F5F9), // Light gray-blue
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: SnackbarWidget(),
    );
  }
}
