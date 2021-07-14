import 'package:eight_queens/PastBoard.dart';
import 'package:eight_queens/results.dart';
import 'package:flutter/material.dart';


class PastResults extends StatefulWidget {
  List<Results> content;

  PastResults({required this.content});

  @override
  _PastResultsState createState() => _PastResultsState(content: content);
}

class _PastResultsState extends State<PastResults> {

  _PastResultsState({ required this.content});

  List<Results> content;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    content = content;
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
                  itemCount: content.length,
                  itemBuilder: (context, index){
                    return HistoryCard(content[index]);
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