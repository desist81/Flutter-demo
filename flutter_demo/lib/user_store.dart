import 'package:shared_preferences/shared_preferences.dart';

class UserStore {
  Future<String> readCollection() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? storedValue = prefs.getString('todo-list');
      return storedValue != null ? storedValue.toString() : '';
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<String> writeCollection(String jsonString) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('todo-list', jsonString);
    return jsonString;
  }
}
