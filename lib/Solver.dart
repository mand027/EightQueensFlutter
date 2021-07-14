import 'package:eight_queens/DataManager.dart';
import 'package:eight_queens/results.dart';

class Solver {
  late List<List<int> > result;
  late List<bool> cols,leftDiagonal,rightDiagonal;
  var workBoard;
  DataManager dataManager = new DataManager();

  List<List<int>> SolveQueensStart(N) {

    workBoard = List.generate(N, (i) => List.filled(N, 0, growable: false), growable: false);
    result = List.generate(0, (i) => List.filled(N, 0, growable: false), growable: true);
    var solutionsA = solveNQ(N);
    saveSolution(N, solutionsA);

    return solutionsA;
  }

  void saveSolution(N, solutions)
  {
    //print("saving:" + solutions.toString());
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

}
