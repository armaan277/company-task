import 'package:company_task/home_screen.dart';
import 'package:company_task/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (_) => LoginScreen(),
        '/home': (_) => const HomeScreen(),
      },
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
    );
  }
}
