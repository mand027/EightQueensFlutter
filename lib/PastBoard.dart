import 'package:eight_queens/DataManager.dart';
import 'package:eight_queens/results.dart';
import 'package:flutter/material.dart';


class PastBoard extends StatefulWidget {
  Results R;

  PastBoard({required this.R});

  @override
  _PastBoardState createState() => _PastBoardState(R: R);
}

class _PastBoardState extends State<PastBoard> {

  _PastBoardState({ required this.R});

  DataManager dataManager = new DataManager();
  Results? R;
  int N = 0;
  var board;

  @override
  void initState() {
    super.initState();

    N = R!.N;
    board = R?.resultArray;
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

