import 'package:flutter/cupertino.dart';

class Movie {
  String? title;
  String? posterUrl;
  String? rating;
  String? released;
  String? runtime;
  String? genre;
  String? actors;
  String? directors;
  String? plot;
  String? boxOffice;

  Movie({
    @required this.title,
    @required this.posterUrl,
    @required this.rating,
    @required this.plot,
    @required this.actors,
    @required this.boxOffice,
    @required this.directors,
    @required this.genre,
    @required this.released,
    @required this.runtime,
  });
}
