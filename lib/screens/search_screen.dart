import 'package:flutter/material.dart';
import 'package:project_2021/providers/favourites.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../providers/searched_movie.dart';
import '../widgets/movie_details.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = './search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _titleController = TextEditingController();
  bool isSearched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a Movie name'),
                    controller: _titleController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    /*Provider.of<MovieList>(context, listen: false)
                        .addMovie(_titleController.text);*/
                    setState(() {
                      isSearched = true;
                    });
                  },
                  icon: Icon(Icons.search),
                  hoverColor: Colors.black12,
                )
              ],
            ),
            isSearched
                ? FutureBuilder(
                    future: Provider.of<MovieList>(context, listen: false)
                        .addMovie(_titleController.text),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? Container(
                                padding: EdgeInsets.all(10),
                                height: 300,
                                width: double.infinity,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ))
                            : Expanded(
                                child: MovieDetails(),
                              ),
                  )
                : Container(
                    padding: EdgeInsets.all(10),
                    height: 300,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Enter something to search 🙄',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
