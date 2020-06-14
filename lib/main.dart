import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(App());

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

class RandomWordPair extends StatefulWidget {
  @override
  RandomWordPairState createState() => RandomWordPairState();
}

class RandomWordPairState extends State<RandomWordPair> {

  final _randomWordPairList = <WordPair>[];
  final _favouriteWordPairs = Set<WordPair>();

  Widget _generateList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, item) {
        if (item.isOdd) {
          return Divider();
        }

        final _index = item ~/ 2;

        if (_index >= _randomWordPairList.length) {
          _randomWordPairList.addAll(generateWordPairs().take(10));
        }

        return _generateRow(_randomWordPairList[_index]);
      }
    );
  }

  Widget _generateRow(WordPair wordPair) {

    final _isFavourite = _favouriteWordPairs.contains(wordPair);

    return ListTile(
      title: Text(
        wordPair.asPascalCase, 
        style: TextStyle(fontSize: 16.0)
      ),
      trailing: Icon(
        _isFavourite ? Icons.favorite : Icons.favorite_border,
        color: _isFavourite ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          if (_isFavourite) {
            _favouriteWordPairs.remove(wordPair);
          }

          else {
            _favouriteWordPairs.add(wordPair);
          }
        });
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Word Pair Generator'),
      ), 
      body: _generateList(),
    );
  }
}