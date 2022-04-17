import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/movie.dart';

class Favourites with ChangeNotifier {
  List<Movie> _favouriteMovies = [];

  List<Movie> get favouriteMovies {
    return [..._favouriteMovies];
  }
  String? token;
  String? userId;
  Favourites(this.token,this.userId,this._favouriteMovies);
  bool isFavourite(String title) {
    for (var movie in _favouriteMovies) {
      if (movie.title == title) {
        return true;
      }
    }
    return false;
  }

  Future<void> removeFav(String title) async {
    var index;
    Movie? deletedMovie;
    for (var movie in _favouriteMovies) {
      if (movie.title == title) {
        index = _favouriteMovies.indexOf(movie);
        deletedMovie = movie;
        break;
      }
    }
    _favouriteMovies.removeAt(index);
    final url = Uri.parse(
        'https://movie-s-app-1bb46-default-rtdb.firebaseio.com/movies/$userId/${deletedMovie!.directors}.json?auth=$token');
    //print(deletedMovie.directors);
    await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    notifyListeners();
  }
  Future<void> fetchAndSetMovies() async{
    final url = Uri.parse('https://movie-s-app-1bb46-default-rtdb.firebaseio.com/movies/$userId.json?auth=$token');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null){
      return;
    }
    //print(extractedData);
    final List<Movie> _loadedMovies = [];
    extractedData.forEach((id, movie) {
      _loadedMovies.add(Movie(
        title: movie['title'],
        rating: movie['rating'],
        posterUrl: movie['posterUrl'],
        directors: id,
      ));
    });
    _favouriteMovies = _loadedMovies;
    notifyListeners();
  }
  Future<void> addFavouriteMovie(
      String title, String posterUrl, String rating) async {
    final url = Uri.parse(
        'https://movie-s-app-1bb46-default-rtdb.firebaseio.com/movies/$userId.json?auth=$token');
    final response = await http.post(url,
        body: json.encode({
          'title': title,
          'posterUrl': posterUrl,
          'rating': rating,
        }));
    _favouriteMovies.add(Movie(
      title: title,
      posterUrl: posterUrl,
      rating: rating,
      directors: json.decode(response.body)['name'],
    ));
    notifyListeners();
  }
}
