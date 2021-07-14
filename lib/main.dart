import 'package:eight_queens/ProblamSolver.dart';
import 'package:eight_queens/results.dart';
import 'package:flutter/material.dart';

import 'DataManager.dart';
import 'PastResults.dart';


//travis CI help https://dev.to/ameysunu/travis-ci-for-flutter-apps-1ngj

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '8 queens problem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int boardSize = 8;
  var history = List<Results>.empty(growable: true);

  void IncrementCounter() {
    setState(() {
      boardSize++;
    });
  }
  void DecreaseCounter() {
    setState(() {
      boardSize--;
      if(boardSize < 4){
        boardSize = 4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    DataManager dataManager = new DataManager();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child:
                Text("N Queens Solver"),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/images/chess.jpg')
                      )
                  ),
              ]
          ),
          SizedBox(height: 50),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ammount of Queens and board size")
              ]
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: 150.0,
                height: 100.0,
                child: ElevatedButton(
                  child: Icon(
                      Icons.remove
                  ),
                  onPressed: ()  async {
                    DecreaseCounter();
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(
                boardSize.toString(),
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 10),
              ButtonTheme(
                minWidth: 150.0,
                height: 100.0,
                child: ElevatedButton(
                  child: Icon(
                      Icons.add
                  ),
                  onPressed: ()  async {
                    IncrementCounter();
                  },
                ),
              )

            ],
          ),
          ButtonTheme(
              minWidth: 150.0,
              height: 100.0,
              child: ElevatedButton(
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                onPressed: ()  async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProblemSolver(N: boardSize,)
                      )
                  );
                },
              )
          ),
          SizedBox(height: 30),
          ButtonTheme(
              minWidth: 150.0,
              height: 100.0,
              child: ElevatedButton(
                child: Text(
                  'Past Results',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                onPressed: ()  async {
                  history = (await dataManager.readcontent())!;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PastResults(content: history)
                      )
                  );
                },
              )
          )
        ],
      ),
    );
  }
}
