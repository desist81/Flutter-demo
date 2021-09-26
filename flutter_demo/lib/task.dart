import 'package:intl/intl.dart' show DateFormat;
import 'package:json_annotation/json_annotation.dart'
    show JsonKey, JsonSerializable;

@JsonSerializable(includeIfNull: false)
class Task {
  @JsonKey(includeIfNull: false)
  final String name;

  @JsonKey(name: 'date')
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
