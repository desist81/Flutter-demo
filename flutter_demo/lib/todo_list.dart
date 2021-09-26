import 'package:json_annotation/json_annotation.dart';

import 'Task.dart';

@JsonSerializable(includeIfNull: false)
class TodoList {
  @JsonKey(includeIfNull: false)
  final String owner;

  @JsonKey(includeIfNull: false)
  final List<Task> tasks;

  TodoList(this.owner, this.tasks);

  TodoList.fromJson(Map<String, dynamic> json)
      : owner = json['owner'],
        tasks = json['tasks'];

  Map<String, dynamic> toJson() => {
        'owner': owner,
        'tasks': tasks,
      };
}
