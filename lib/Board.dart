import 'package:flutter/material.dart';
import './Cell.dart';

class CellData {
  CellData({this.color, this.val});
  int val;
  Color color;
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<List<CellData>> board;
  List<Color> players;
  int turn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    turn = 0;
    board = new List<List<CellData>>();

    for (int j = 0; j < 11; j++) {
      List<CellData> row = List<CellData>();
      for (int i = 0; i < 6; i++) {
        row.add(CellData(color: Colors.black, val: 0));
      }
      board.add(row);
    }
    print(board);
    players = List<Color>();
    players.add(Colors.red);
    players.add(Colors.green);
  }

  void handleTap(int i, int j, Color color) {
    board[i][j].color = color;
    if (i == 0 && j == 0) {
      board[i][j].val += 1;
      if (board[i][j].val > 1) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j + 1, color);
        handleTap(i + 1, j, color);
      }
    } else if (i == 0 && j == 5) {
      board[i][j].val += 1;
      if (board[i][j].val > 1) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j - 1, color);
        handleTap(i + 1, j, color);
      }
    } else if (i == 10 && j == 0) {
      board[i][j].val += 1;
      if (board[i][j].val > 1) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j + 1, color);
      }
    } else if (i == 10 && j == 5) {
      board[i][j].val += 1;
      if (board[i][j].val > 1) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j - 1, color);
      }
    } else if (i == 0) {
      board[i][j].val += 1;
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j - 1, color);
        handleTap(i, j + 1, color);
        handleTap(i + 1, j, color);
      }
    } else if (j == 0) {
      board[i][j].val += 1;
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j + 1, color);
        handleTap(i + 1, j, color);
      }
    } else if (i == 10) {
      board[i][j].val += 1;
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j - 1, color);
        handleTap(i, j + 1, color);
        handleTap(i - 1, j, color);
      }
    } else if (j == 5) {
      board[i][j].val += 1;
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j - 1, color);
        handleTap(i + 1, j, color);
      }
    } else {
      board[i][j].val += 1;
      if (board[i][j].val > 3) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j - 1, color);
        handleTap(i, j + 1, color);
        handleTap(i + 1, j, color); //there may be a bug here
        handleTap(i - 1, j, color);
      }
    }
  }

  Widget buildBoard() {
    List<Row> row = List<Row>();
    for (int i = 0; i < 11; i++) {
      List<GestureDetector> cell = List<GestureDetector>();
      for (int j = 0; j < 6; j++) {
        cell.add(GestureDetector(
          onTap: () {
            if (players[turn] == board[i][j].color ||
                board[i][j].color == Colors.black)
              setState(() {
                handleTap(i, j, players[turn]);
                turn++;
                if (turn == players.length) {
                  turn = 0;
                }
              });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 3),
            color: Colors.transparent,
            child: Cell(
                val: board[i][j].val,
                color: board[i][j].color,
                border: players[turn]),
          ),
        ));
      }
      row.add(Row(
        children: cell,
      ));
    }
    return Column(
      children: row,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildBoard(),
    );
  }
}
