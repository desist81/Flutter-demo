import 'package:flutter_demo/model/task_item.dart';

class TodoList {
  final String owner;
  final List<TaskItem> tasks;

  TodoList(this.owner, this.tasks);

  Map toJson() {
    List<Map> tasks = this.tasks.map((i) => i.toJson()).toList();

    return {'owner': owner, 'tasks': tasks};
  }

  factory TodoList.fromJson(dynamic json) {
    if (json['tasks'] != null) {
      var taskObjsJson = json['tasks'] as List;
      List<TaskItem> _tasks =
          taskObjsJson.map((taskJson) => TaskItem.fromJson(taskJson)).toList();

      return TodoList(json['owner'] as String, _tasks);
    } else {
      return TodoList(json['owner'] as String, <TaskItem>[]);
    }
  }

  @override
  String toString() {
    return '{ $owner, $tasks }';
  }
}
