import 'package:eight_queens/DataManager.dart';
import 'package:eight_queens/results.dart';
import 'package:flutter/material.dart';


class ProblemSolver extends StatefulWidget {
  int N;

  ProblemSolver({required this.N});

  @override
  _ProblemSolverState createState() => _ProblemSolverState(N: N);
}

class _ProblemSolverState extends State<ProblemSolver> {

  _ProblemSolverState({ required this.N});

  DataManager dataManager = new DataManager();
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
    workBoard = List.generate(N, (i) => List.filled(N, 0, growable: false), growable: false);
    showBoard = List.generate(N, (i) => List.filled(N, 0, growable: false), growable: false);
    result = List.generate(0, (i) => List.filled(N, 0, growable: false), growable: true);

    SolveQueensStart();
  }

  void SolveQueensStart() {

    solutions = solveNQ(N);
    saveSolution();
    fillCurrentQueens();
  }

  void saveSolution()
  {
    print("saving:" + solutions.toString());
    Results Saved = Results(N: N, resultArray: solutions);
    dataManager.writeContent(Saved);
  }

  /* This code (HERE and down) was adapted to dart based on code by PrinciRaj1992 from: https://www.geeksforgeeks.org/printing-solutions-n-queen-problem*/
  static bool isSafe(board, int row, int col, int N)
  {
  int i, j;

  /* Check this row on left side */
  for (i = 0; i < col; i++)
  if (board[row][i] == 1)
  return false;

  /* Check upper diagonal on left side */
  for (var i = row, j = col; i >= 0 && j >= 0; i--, j--)
  if (board[i][j] == 1)
  return false;

  /* Check lower diagonal on left side */
  for (var i = row, j = col; j >= 0 && i < N; i++, j--)
  if (board[i][j] == 1)
  return false;

  return true;
  }

  /* A recursive utility function
    to solve N Queen problem */
  bool solveNQUtil(board, int col, int N)
  {
  /* base case: If all queens are placed
        then return true */

  if (col == N) {
  List<int> v = List.empty(growable: true);
  for (int i = 0; i < N; i++)
  for (int j = 0; j < N; j++) {
  if (board[i][j] == 1)
  v.add(j + 1);
  }
  result.add(v);
  return true;
  }

  /* Consider this column and try placing
        this queen in all rows one by one */
  bool res = false;
  for (int i = 0; i < N; i++) {
  /* Check if queen can be placed on
            board[i,col] */
  if (isSafe(board, i, col, N)) {
  /* Place this queen in board[i,col] */
  board[i][col] = 1;

  // Make result true if any placement
  // is possible
  res = solveNQUtil(board, col + 1, N) || res;

  /* If placing queen in board[i,col]
                doesn't lead to a solution, then
                remove queen from board[i,col] */
  board[i][col] = 0; // BACKTRACK
  }
  }

  /* If queen can not be place in any row in
            this column col then return false */
  return res;
  }

  /* This function solves the N Queen problem using
    Backtracking. It mainly uses solveNQUtil() to
    solve the problem. It returns false if queens
    cannot be placed, otherwise return true and
    prints placement of queens in the form of 1s.
    Please note that there may be more than one
    solutions, this function prints one of the
    feasible solutions.*/

  List<List<int>> solveNQ(int n)
  {

  solveNQUtil(workBoard, 0, n);
    return result;
  }
  /*shared code ends*/

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

