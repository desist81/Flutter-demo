import 'package:intl/intl.dart';

class TaskItem {
  final String name;
  final DateTime date;

  TaskItem(this.name, this.date) {
    if (name.isEmpty) {
      throw ArgumentError("Task name cannot be empty. "
          "Received: '$name'");
    }
  }

  factory TaskItem.fromJson(dynamic json) {
    return TaskItem(
        json['name'] as String, DateTime.parse(json['date'] as String));
  }

  Map toJson() => {
        'name': name,
        'date': date.toString(),
      };

  String formattedDate() {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    return '$name; date: $formattedDate';
  }

  @override
  String toString() {
    return '{ $name, $date }';
  }
}
