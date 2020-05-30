import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  Cell({this.val, this.color, this.call_back, this.border});
  final val;
  final color;
  final call_back;
  final border;
  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  double scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.lightBlue,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(width: 2, color: this.widget.border),
              bottom: BorderSide(width: 2, color: this.widget.border))),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 6,
        maxHeight: MediaQuery.of(context).size.height / 13,
      ),
      child: FlareActor(
        'flare/BottomRow.flr',
        animation: 'split',
        color: Colors.lightBlue,
        fit: BoxFit.contain,
        sizeFromArtboard: true,
      ),
    );
  }
}
//Center(
//child: widget.val == 0
//? Container(
//color: Colors.white,
//)
//: Image.asset(
//"images/${widget.val}.jpg",
//fit: BoxFit.contain,
//color: this.widget.color,
//colorBlendMode: BlendMode.color,
//),
//),
