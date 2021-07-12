import 'package:eight_queens/ProblamSolver.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  int boardSize = 4;

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

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 1, child: SizedBox(),),
            Expanded(
              child: Center(
                child:
                Text("8 Queens"), //cambiar por logo nuev
              ),
            ),
            Expanded(flex: 1, child: SizedBox(),),
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
                      Icons.exposure_minus_1
                  ),
                  onPressed: ()  async {
                    DecreaseCounter();
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(
                  boardSize.toString() + "",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 10),
              ButtonTheme(
                minWidth: 150.0,
                height: 100.0,
                child: ElevatedButton(
                  child: Icon(
                      Icons.plus_one
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

                },
              )
          )
        ],
      ),
    );
  }
}
