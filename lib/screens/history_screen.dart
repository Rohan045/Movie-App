import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/searched_movie.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = './historyScreen';

  Widget build(BuildContext context) {
    final movies = Provider.of<MovieList>(context).revMovies;
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (ctx, i) => movies[i].title == 'Loading'
              ? Divider()
              : ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    child: Text(
                      '${i+1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    movies[i].title!,
                    style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),
                  ),
                )),
    );
  }
}
