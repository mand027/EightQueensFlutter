import 'package:eight_queens/PastBoard.dart';
import 'package:eight_queens/results.dart';
import 'package:flutter/material.dart';


class PastResults extends StatefulWidget {
  String content;

  PastResults({required this.content});

  @override
  _PastResultsState createState() => _PastResultsState(content: content);
}

class _PastResultsState extends State<PastResults> {

  _PastResultsState({ required this.content});

  String content;
  List<Results>? lista;

  @override
  void initState() {
    super.initState();
    lista = fixData();
  }

  List<Results> fixData(){

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
      print("res: " +R.N.toString() + ": "+ R.resultArray.toString());
      lista.add(R);
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    lista = lista;
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            titleSpacing: 18.0,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Result history',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]
            )
        ),
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: Scaffold(
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: lista?.length,
                  itemBuilder: (context, index){
                    return HistoryCard(lista![index]);
                  },
                )
            )
        )
    );
  }

  Widget HistoryCard(Results R) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(1),
            child: Card(
                child: Container(
                    child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text("You checked for N = " +R.N.toString())
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ElevatedButton(
                                  child: Text(
                                    'See Result',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: ()  async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PastBoard(R: R)
                                        )
                                    );
                                  },
                                ),
                              )
                            ],
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}