import 'package:intl/intl.dart';

class Task {
  /// The first part of the pair.
  final String name;

  /// The second part of the pair.
  final DateTime date;
  late final String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(date);
  late final String asString = '$name; date: $formattedDate';

  /// Create a [Task] from the strings [first] and [second].
  Task(this.name, this.date) {
    if (name.isEmpty) {
      throw ArgumentError("Task name cannot be empty. "
          "Received: '$name'");
    }
  }
  @override
  String toString() => asString;
}
