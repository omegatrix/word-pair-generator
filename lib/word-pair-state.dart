import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'word-pair-generator.dart';

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
        _isFavourite ? 
          Icons.favorite : Icons.favorite_border,
        color: _isFavourite ? 
          Colors.red : null
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

  void _pushFavourite() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> _tiles = 
            _favouriteWordPairs.map(
              (WordPair wordPair) {
                return ListTile(
                  title: Text(
                    wordPair.asPascalCase, 
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              }
            );

            final List<Widget> divided = 
              ListTile.divideTiles(
                context: context, 
                tiles: _tiles
              ).toList();

              return Scaffold(
                appBar: AppBar(
                  title: Text('Favourites')
                ),
                body: ListView(children: divided),
              );
        } 
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Word Pair Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushFavourite
          )
        ],
      ), 
      body: _generateList(),
    );
  }
}