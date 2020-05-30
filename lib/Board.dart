import 'dart:async';
import 'dart:convert';
//import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
//import './Cell.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class CellData {
  CellData({this.color, this.val}) {
    type = "Onetopleft";
    animation = "Triangle";
    control = FlareControls();
    control.play("Triangle");
  }
  int val;
  Color color;
  String type;
  String animation;
  FlareControls control;
}

class Board extends StatefulWidget {
  final String name;
  final String room;
  Board({this.name, this.room});
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<List<CellData>> board;
  List<Color> players;
  int turn;
  SocketIOManager manager;
  SocketIO socket;
  bool isAble;
  void socketInit() async {
    print('Begining connection');
    manager = SocketIOManager();
    socket = await manager.createInstance(
        SocketOptions('https://chain-reactor-back.herokuapp.com'));

    socket.onConnect((data) {
      print("connected...");
      print(data);
      socket.emit("message", ["Hello world!"]);
    });
    socket.emit("join", [
      {"username": widget.name, "room": widget.room}
    ]);
    socket.on('otherusermove', (val) {
      print(val[0]);
      setState(() {
        isAble = true;
        handleTap(val[0], val[1], players[turn]);
        turn++;
        if (turn == players.length) {
          turn = 0;
        }
      });
    });
    socket.connect();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    turn = 0;
    board = new List<List<CellData>>();
    isAble = true;
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
    socketInit();
  }

  void handleTap(int i, int j, Color color) {
    board[i][j].color = color;
    if (i == 0 && j == 0) {
      //
      board[i][j].val += 1;
      board[i][j].type = "Onetopleft";
      if (board[i][j].val > 1) {
//        board[i][j].control.;
//        board[i][j].control.play("split");

//        Timer(Duration(milliseconds: 500), () {
//          setState(() {
//            board[i][j].control.play("Triangle");
//            board[i][j].animation = "Triangle";
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j + 1, color);
        handleTap(i + 1, j, color);
//          });
//        });
      }
    } else if (i == 0 && j == 5) {
      board[i][j].type = "Onetopright";
      board[i][j].val += 1;
      if (board[i][j].val > 1) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j - 1, color);
        handleTap(i + 1, j, color);
      }
    } else if (i == 10 && j == 0) {
      board[i][j].type = "OneBottomLeft";
      board[i][j].val += 1;
      if (board[i][j].val > 1) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j + 1, color);
      }
    } else if (i == 10 && j == 5) {
      board[i][j].type = "Onebottomright";
      board[i][j].val += 1;
      if (board[i][j].val > 1) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j - 1, color);
      }
    } else if (i == 0) {
      board[i][j].val += 1;
      if (board[i][j].val == 2)
        board[i][j].type = "Upperrow";
      else {
        if (board[i][j].val == 1) board[i][j].type = "OneBottomLeft";
      }
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j - 1, color);
        handleTap(i, j + 1, color);
        handleTap(i + 1, j, color);
      }
    } else if (j == 0) {
      board[i][j].val += 1;
      if (board[i][j].val == 2)
        board[i][j].type = "Leftcolumn";
      else {
        if (board[i][j].val == 1) board[i][j].type = "OneBottomLeft";
      }
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j + 1, color);
        handleTap(i + 1, j, color);
      }
    } else if (i == 10) {
      board[i][j].val += 1;
      if (board[i][j].val == 2)
        board[i][j].type = "Bottomrow";
      else {
        if (board[i][j].val == 1) board[i][j].type = "OneBottomLeft";
      }
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i, j - 1, color);
        handleTap(i, j + 1, color);
        handleTap(i - 1, j, color);
      }
    } else if (j == 5) {
      board[i][j].val += 1;
      if (board[i][j].val == 2)
        board[i][j].type = "Rightcolumn";
      else {
        if (board[i][j].val == 1) board[i][j].type = "OneBottomLeft";
      }
      if (board[i][j].val > 2) {
        board[i][j].val = 0;
        board[i][j].color = Colors.black;
        handleTap(i - 1, j, color);
        handleTap(i, j - 1, color);
        handleTap(i + 1, j, color);
      }
    } else {
      board[i][j].val += 1;
      if (board[i][j].val == 3)
        board[i][j].type = "ThreeCircle";
      else {
        if (board[i][j].val == 1)
          board[i][j].type = "OneBottomLeft";
        else
          board[i][j].type = "Bottomrow";
      }
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
          onTap: isAble
              ? () {
                  if (players[turn] == board[i][j].color ||
                      board[i][j].color == Colors.black)
                    setState(() {
                      socket.emit('move', [
                        [i, j]
                      ]);
                      isAble = false;
//                      print({'x': i, 'y': j});
                      handleTap(i, j, players[turn]);
                      turn++;
                      if (turn == players.length) {
                        turn = 0;
                      }
                    });
                }
              : null,
          child: Container(
            color: Colors.transparent,
            child: Container(
//      color: Colors.lightBlue,
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1, color: players[turn]),
                    bottom: BorderSide(width: 1, color: players[turn]),
                    top: BorderSide(width: 1, color: players[turn]),
                    left: BorderSide(width: 1, color: players[turn])),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 6,
                maxHeight: MediaQuery.of(context).size.height / 13,
              ),
              child: Container(
                color: Colors.black,
                child: FlareActor(
                  'flare/${board[i][j].type}.flr',
                  animation: "Triangle",
                  color: board[i][j].color,
                  fit: BoxFit.fitHeight,
                  sizeFromArtboard: false,
                  controller: board[i][j].control,
                ),
              ),
            ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildBoard(),
        ],
      ),
    );
  }
}
//Cell(
//val: board[i][j].val,
//color: ,
//border: players[turn])
