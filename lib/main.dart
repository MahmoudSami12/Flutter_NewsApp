import 'package:flutter/material.dart';
import 'package:nooooooooote/screens/addNote.dart';
import 'package:nooooooooote/screens/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: const Home(),
      debugShowCheckedModeBanner: false,
      routes: {'addNote': (context) => const addNote()},
    );
  }
}
