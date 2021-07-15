import 'dart:async';
import 'dart:io';
import 'package:eight_queens/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class DataManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final file = File('$path/data.txt');
    return file;
  }

  void createFile() async{
    final path = await _localPath;
    final file = File('$path/data.txt');
    file.create();
  }

  Future<List<Results>?> readcontent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();

      var resultList = TextToData(contents);
      return resultList;
    } catch (e) {
      // If there is an error reading, return a default String
      return null;
    }
  }

  Future<File> writeContent(Results result) async {

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

    //print(dividedObjects);

    for (int i = 0; i < dividedObjects.length; i++) {
      var dividedIndividualEntry = dividedObjects[i].split(":");
      var N = int.parse(dividedIndividualEntry[0]);
      resultArray = List.empty(growable: true);
      List auxresultArray = List.filled(N, 0);
      final iReg = RegExp(r'(\d+)');
      var test = iReg.allMatches(dividedIndividualEntry[1]).map((m) => m.group(0)).join(' ');
      var nums = test.split(" ");
      //print(nums);
      //print((nums.length/N).toString());
      int c = 0;
      for (int i = 0; i <= (nums.length/N) -1; i++) {
        auxresultArray = List.generate(N, (index) => 0);
        for (int j = 0; j < N; j++) {
          auxresultArray[j] = int.parse(nums[c]);
          c++;
        }
        resultArray.add(auxresultArray);
      }
      //print(resultArray);
      R = Results(N: N, resultArray: resultArray);
      //print("res: " +R.N.toString() + ": "+ R.resultArray.toString());
      lista.add(R);
    }
    return lista;
  }

}