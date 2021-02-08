import 'package:flutter/material.dart';
import 'ToDoScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
        backgroundColor: Colors.black54,
      ),
      body: ToDoScreen(),
    );
  }
}
