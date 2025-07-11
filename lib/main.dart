import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/InputForm.dart';
import 'package:to_do_app/pages/edit_todo.dart';
import 'package:to_do_app/pages/login.dart';
import 'package:to_do_app/providers/TodoProvider.dart';
import 'package:to_do_app/service/ThemeProvider.dart';
import 'package:to_do_app/providers/user_provider.dart';
import 'package:to_do_app/service/notification_todo.dart';
import 'pages/Home.dart';
import 'package:google_fonts/google_fonts.dart';

final GoRouter _route = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/Home', builder: (context, state) => const MainHomeScreen()),
    GoRoute(path: '/InputForm', builder: (context, state) => const Inputform()),
    GoRoute(
      path: '/EditTodo',
      builder: (context, state) {
        final id = state.extra as String;
        return EditTodo(todoId: id.toString());
      },
    ),
    // GoRoute(
    //   path: '/notification',
    //   builder: (context, state) => const NotificationPage(),
    // ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, _) {
          return MaterialApp.router(
            theme: value.currentTheme.copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(),

              //custom color = const Color(0xFFFAF5EC),
            ),

            debugShowCheckedModeBanner: false, // Remove debug banner
            routerConfig: _route,
          );
        },
      ),
    );
  }
}
