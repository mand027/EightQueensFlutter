import 'package:eight_queens/Solver.dart';
import 'package:flutter/material.dart';


class ProblemSolver extends StatefulWidget {
  int N;

  ProblemSolver({required this.N});

  @override
  _ProblemSolverState createState() => _ProblemSolverState(N: N);
}

class _ProblemSolverState extends State<ProblemSolver> {

  _ProblemSolverState({ required this.N});

  Solver solver = new Solver();
  int N;
  var workBoard;
  var showBoard;
  var solutions = List.empty(growable: true);
  var selectedBoard = 0;

  late List<List<int> > result;
  late List<bool> cols,leftDiagonal,rightDiagonal;

  @override
  void initState() {
    super.initState();
    showBoard = List.generate(N, (i) => List.filled(N, 0, growable: false), growable: false);

    solutions = solver.SolveQueensStart(N);
    fillCurrentQueens();
  }

  void fillCurrentQueens(){
    showBoard = List.generate(N, (i) => List.filled(N, 0, growable: false), growable: false);
    var currentSols = solutions[selectedBoard];
    for(var i = 0; i< N; i++){
      for(var j = 0; j< currentSols[i]; j++){
        if(j == (currentSols[i] - 1)){
          showBoard[i][j] = 1;
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {

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
                      'Result for: ' + N.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]
            )
        ),
        body:
        Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0)
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: N,
                    ),
                    itemBuilder: _PlaceQueens,
                    itemCount: N * N,
                  ),
                ),
              ),
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
                          setState(() {
                            selectedBoard--;
                            if(selectedBoard <= 0 ){
                              selectedBoard = 0;
                            }
                            fillCurrentQueens();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Solution: "+(selectedBoard +1).toString()+"/"+(solutions.length).toString(),
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
                          setState(() {
                            selectedBoard++;
                            if(selectedBoard >= solutions.length -1){
                              selectedBoard = solutions.length -1;
                            }
                            fillCurrentQueens();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
        )
    );
  }

  Widget _PlaceQueens(BuildContext context, int index) {
    int gridStateLength = showBoard.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      child: GridTile(
        child: Container(
          decoration: N%2 == 0 ?
          BoxDecoration(
              color: (x%2 != 0 && y%2 != 0) || (x%2 == 0 && y%2 == 0)  ? Colors.teal : Colors.white,
              border: Border.all(color: Colors.black, width: 0.5)
          ) :
          BoxDecoration(
              color: index%2 == 0 ? Colors.teal : Colors.white,
              border: Border.all(color: Colors.black, width: 0.5)
          ),
          child: _buildGridItem(x, y),
        ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {
    switch (showBoard[x][y]) {
      case 1:
        return Container(child: Image.asset('assets/images/Queen.png'));
        break;
      case 0:
        return Text('');
        break;
      default:
        return Text(showBoard[x][y].toString());
    }
  }
}

