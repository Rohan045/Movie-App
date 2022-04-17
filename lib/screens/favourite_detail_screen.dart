import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_details.dart';
import '../providers/searched_movie.dart';

class FavouriteDetailsScreen extends StatelessWidget {
  static const routeName = './FavouriteDetailsScreen';

  FavouriteDetailsScreen();

  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: Provider.of<MovieList>(context, listen: false).addMovie(title),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[Expanded(child: MovieDetails())],
                  ),
      ),
    );
  }
}
