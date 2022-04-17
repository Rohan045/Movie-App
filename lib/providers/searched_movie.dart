import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_2021/providers/favourites.dart';
import 'package:provider/provider.dart';

import '../model/movie.dart';

class MovieList with ChangeNotifier {
  static const API_KEY = '28778e02';
  List<Movie> _movies = [
    Movie(
      title: 'Loading',
      posterUrl: 'Loading',
      actors: 'Loading',
      boxOffice: 'Loading',
      directors: 'Loading',
      genre: 'Loading',
      plot: 'Loading',
      rating: 'Loading',
      released: 'Loading',
      runtime: 'Loading',
    ),
  ];

  List<Movie> get revMovies {
    return [..._movies.reversed];
  }

  List<Movie> get movies {
    return [..._movies];
  }

  void clearList() {
    _movies = [];
    notifyListeners();
  }

  Movie findMovie() {
    return _movies[_movies.length - 1];
  }

  Future<void> addMovie(String title) async {
    final Uri url =
        Uri.parse('http://www.omdbapi.com/?t=$title&apikey=$API_KEY');
    final response = await http.get(url);
    final details = json.decode(response.body);
    print(details['Plot']);
    _movies.add(Movie(
      title: details['Title'] == null ? 'N/A' : details['Title'],
      posterUrl: details['Poster'] == null ? 'N/A' : details['Poster'],
      actors: details['Actors'] == null ? 'N/A' : details['Actors'],
      boxOffice: details['BoxOffice'] == null ? 'N/A' : details['BoxOffice'],
      directors: details['Director'] == null ? 'N/A' : details['Director'],
      genre: details['Genre'] == null ? 'N/A' : details['Genre'],
      plot: details['Plot'] == null ? 'N/A' : details['Plot'],
      rating: details['imdbRating'] == null ? 'N/A' : details['imdbRating'],
      released: details['Released'] == null ? 'N/A' : details['Released'],
      runtime: details['Runtime'] == null ? 'N/A' : details['Runtime'],
    ));
    notifyListeners();
  }
}
