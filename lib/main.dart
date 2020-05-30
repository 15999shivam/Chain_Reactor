import 'package:flutter/material.dart';
import 'package:chain_reactor/JoinRoom.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Chain_Reactor"),
        ),
        body: JoinRoom(),
      ),
    );
  }
}
