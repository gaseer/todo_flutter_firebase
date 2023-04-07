import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/todo_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'flutter_todo_app',
    options: const FirebaseOptions(
      apiKey: "AIzaSyBqz_Z1kXgs9dO0KVqIUhf3aGmjH3wNhKE",
      appId: "1:887658149074:android:a67bb326a4631ab1a0a90b",
      messagingSenderId: 'xxssx',
      projectId: "flutter-todo-96e85",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
      ),
      debugShowCheckedModeBanner: false,
      home: TodolistPage(),
    );
  }
}
