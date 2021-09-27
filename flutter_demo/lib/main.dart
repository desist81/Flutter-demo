import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/list_page_widget';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const ListPage(title: 'Flutter Demo Home Page'),
    );
  }
}
