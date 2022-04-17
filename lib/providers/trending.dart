import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/movie.dart';

class Trending with ChangeNotifier {
  static const API_KEY = '28778e02';
  List<Movie> trend = [];
  Future<void> getTrendingMovies() async {
    trend = [];
    final url = Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=ae78a38d97868b7e097657fcb7570877');
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    final movieList = extractedData['results'] as List;
    var title;
    var response2;
    var details;
    //print(movieList.length);
    int i = 0;
    while(i!=movieList.length){
      if (movieList[i]['name'] == null) {
        if (movieList[i]['title'] == null) {
          if (movieList[i]['original_title'] == null) {
            title = null;
          } else {
            title = movieList[i]['original_title'];
          }
        } else {
          title = movieList[i]['title'];
        }
      } else {
        title = movieList[i]['name'];
      }
      //print(title);
      i++;
      Uri url2 = Uri.parse('http://www.omdbapi.com/?t=$title&apikey=$API_KEY');
      response2 = await http.get(url2);
      details = json.decode(response2.body);
      //print(details['Title']);
      trend.add(Movie(
        title: details['Title'] == null ? title : details['Title'],
        posterUrl: details['Poster'] == null ? 'N/A' : details['Poster'],
        rating: details['imdbRating'] == null ? 'N/A' : details['imdbRating'],
      ));
    }
    notifyListeners();
  }
}
