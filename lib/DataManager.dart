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

  Future<List<Results>?> readcontent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();

      //print(contents.toString());
      var resultList = TextToData(contents);
      return resultList;
    } catch (e) {
      // If there is an error reading, return a default String
      return null;
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


  List<Results> TextToData(String content){

    List<Results> lista = List<Results>.empty(growable: true);
    Results R;
    List resultArray;

    var dividedObjects = content.split('-');
    dividedObjects.removeLast();

    for (int i = 0; i < dividedObjects.length; i++) {
      var dividedIndividualEntry = dividedObjects[i].split(":");
      var N = int.parse(dividedIndividualEntry[0]);
      resultArray = List.generate(N, (i) => List.filled(N, 0, growable: false), growable: false);
      final iReg = RegExp(r'(\d+)');
      var test = iReg.allMatches(dividedIndividualEntry[1]).map((m) => m.group(0)).join(' ');
      var nums = test.split(" ");
      int c = 0;
      for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
          resultArray[i][j] = int.parse(nums[c]);
          c++;
        }
      }
      R = Results(N: N, resultArray: resultArray);
      //print("res: " +R.N.toString() + ": "+ R.resultArray.toString());
      lista.add(R);
    }
    return lista;
  }

}