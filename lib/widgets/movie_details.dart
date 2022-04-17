import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/searched_movie.dart';
import '../providers/favourites.dart';

class MovieDetails extends StatelessWidget {
  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.left,
        ));
  }

  Widget buildContainer(Widget child, double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchedMovie = Provider.of<MovieList>(context)
        .movies[Provider.of<MovieList>(context).movies.length - 1];
    return Container(
      width: double.infinity,
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: searchedMovie.posterUrl == 'N/A'
                  ? Center(
                      child: Text('N/A'),
                    )
                  : searchedMovie.posterUrl == 'Loading'
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Image.network(
                          searchedMovie.posterUrl!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
            ),
            buildSectionTitle(context, 'Title'),
            buildContainer(
                Text(
                  searchedMovie.title!,
                  style: TextStyle(fontSize: 20),
                ),
                50),
            buildSectionTitle(context, 'IMDB Rating'),
            buildContainer(
                Text(
                  searchedMovie.rating!,
                  style: TextStyle(fontSize: 20),
                ),
                50),
            buildSectionTitle(context, 'Release Date'),
            buildContainer(
                Text(
                  searchedMovie.released!,
                  style: TextStyle(fontSize: 20),
                ),
                50),
            buildSectionTitle(context, 'Genre'),
            buildContainer(
                Text(
                  searchedMovie.genre!,
                  style: TextStyle(fontSize: 20),
                ),
                50),
            buildSectionTitle(context, 'Actors'),
            buildContainer(
                Text(
                  searchedMovie.actors!,
                  style: TextStyle(fontSize: 20),
                ),
                70),
            buildSectionTitle(context, 'Directors'),
            buildContainer(
                Text(
                  searchedMovie.directors!,
                  style: TextStyle(fontSize: 20),
                ),
                70),
            buildSectionTitle(context, 'Plot'),
            buildContainer(
                Text(
                  searchedMovie.plot!,
                  style: TextStyle(fontSize: 20),
                ),
                200),
            TextButton.icon(
                onPressed: Provider.of<Favourites>(context).isFavourite(
                        searchedMovie
                            .title!)
                    ? () {
                        Provider.of<Favourites>(context, listen: false)
                            .removeFav(searchedMovie.title!);
                      }
                    : () {
                        {
                          Provider.of<Favourites>(context, listen: false)
                              .addFavouriteMovie(
                                  searchedMovie.title!,
                                  searchedMovie.posterUrl!,
                                  searchedMovie.rating!);
                        }
                      },
                icon: Icon(
                  Provider.of<Favourites>(context).isFavourite(
                          searchedMovie
                              .title!)
                      ? Icons.star
                      : Icons.star_border,
                ),
                label: Text(Provider.of<Favourites>(context).isFavourite(
                        searchedMovie
                            .title!)
                    ? 'Mark Unfavourite'
                    : 'Mark Favourite'))
          ],
        ),
      ),
    );
  }
}
