import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todoList.json');
  }

  Future<String> readCollection() async {
    try {
      final file = await _localFile;

      // Read the file
      final content = await file.readAsString();

      return content;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> writeCollection(String jsonString) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(jsonString);
  }
}
