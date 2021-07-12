import 'dart:async';
import 'dart:io';
import 'package:eight_queens/results.dart';
import 'package:path_provider/path_provider.dart';

class DataManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> readcontent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();

      //print(contents.toString());
      return contents;
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }

  Future<File> writeContent(Results result) async {

    Map<String, dynamic> content = new Map();

    final file = await _localFile;
    String contents = await file.readAsString();
    String newItem = result.N.toString() + ":" + result.resultArray.toString() + "-";
    String addThis = contents + newItem;
    return file.writeAsString(addThis);
  }
}