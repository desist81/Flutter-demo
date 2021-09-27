import 'dart:convert';
import 'package:flutter/material.dart';
import 'task_item.dart';
import 'todo_list.dart';
import 'user_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TaskItem> _taskList = <TaskItem>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final UserStore storage = UserStore();

  Widget _buildTaskList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i < _taskList.length) {
            return _buildRow(_taskList[i]);
          } else {
            return ListTile(
              title: Text('', style: _biggerFont),
            );
          }
        });
  }

  Widget _buildRow(TaskItem task) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            task.formattedDate(),
            style: _biggerFont,
          ),
        ),
        const Divider(),
      ],
    );
  }

  void _incrementCounter() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildPopupDialog(context),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    String _newTask = '';
    return AlertDialog(
      title: const Text('New task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter a task...',
              labelText: 'New task',
            ),
            onChanged: (value) {
              _newTask = value.toString();
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              _taskList.add(TaskItem(_newTask, DateTime.now()));
            });
            TodoList todoTaskList = TodoList('Flutter-demo', _taskList);
            String jsonTodoTaskList = jsonEncode(todoTaskList);
            storage.writeCollection(jsonTodoTaskList);
            Navigator.of(context).pop();
          },
          child: const Text('Create'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    storage.readCollection().then((String value) {
      if (value.isNotEmpty) {
        TodoList todo = TodoList.fromJson(jsonDecode(value));
        setState(() {
          _taskList = todo.tasks;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
