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
  var board;
  var ld = new List.filled(100, 0, growable: false);
  var rd = new List.filled(100, 0, growable: false);
  var cl = new List.filled(100, 0, growable: false);

  @override
  void initState() {
    super.initState();

    board = List.generate(N, (i) => List.filled(N, 0, growable: false), growable: false);

    SolveQueensStart();
  }

  void saveSolution(board)
  {
    var result = Results(N: N, resultArray: board);
    dataManager.writeContent(result);
  }

  /* Queens Solution based on code by Princi Singh in https://www.geeksforgeeks.org/n-queen-problem-backtracking-3/ */
  void SolveQueensStart() {

    if (solveQueensRecursive(board, 0) == false)
    {
      print("Solution does not exist");
    }
    else{
      saveSolution(board);
    }
  }

  bool solveQueensRecursive(board, int col){
    /* base case: If all queens are placed
    then return true */
    if (col >= N)
      return true;

    /* Consider this column and try placing
    this queen in all rows one by one */
    for (int i = 0; i < N; i++)
    {

      /* Check if the queen can be placed on
        board[i][col] */
      /* A check if a queen can be placed on
        board[row][col].We just need to check
        ld[row-col+n-1] and rd[row+coln] where
        ld and rd are for left and right
        diagonal respectively*/
      if ((ld[i - col + N - 1] != 1 &&
          rd[i + col] != 1) && cl[i] != 1)
      {
        /* Place this queen in board[i][col] */
        board[i][col] = 1;
        ld[i - col + N - 1] =
        rd[i + col] = cl[i] = 1;

        /* recur to place rest of the queens */
        if (solveQueensRecursive(board, col + 1))
          return true;

        /* If placing queen in board[i][col]
            doesn't lead to a solution, then
            remove queen from board[i][col] */
        board[i][col] = 0; // BACKTRACK
        ld[i - col + N - 1] =
        rd[i + col] = cl[i] = 0;
      }
    }

    /* If the queen cannot be placed in any row in
        this colum col then return false */
    return false;
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
          ])
    );
  }

  Widget _PlaceQueens(BuildContext context, int index) {
    int gridStateLength = board.length;
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
    switch (board[x][y]) {
      case 1:
        return Container(child: Image.asset('assets/images/Queen.png'));
        break;
      case 0:
        return Text('');
        break;
      default:
        return Text(board[x][y].toString());
    }
  }
}

