import 'package:flutter/material.dart';
import 'word-pair-generator.dart';

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent[700],
        accentColor: Colors.tealAccent
      ),
      home: RandomWordPair()
    );
  } 
}