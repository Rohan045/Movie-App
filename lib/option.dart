import 'package:flutter/material.dart';

import './screens/trending_screen.dart';
import './screens/favourites_screen.dart';
import './model/option_model.dart';
import './screens/search_screen.dart';
import './screens/top10_screen.dart';


 const optionCategory = const [
  Option(
    title: 'Search',
    color: Colors.purple,
    routeName: SearchScreen.routeName,
  ),
   Option(
     title: 'Favourites',
     color: Colors.blue,
     routeName: FavouritesScreen.routeName,
   ),
   Option(
     title: 'Top 10',
     color: Colors.red,
     routeName: Top10Screen.routeName,
   ),
   Option(
     title: 'Trending Today',
     color: Colors.pink,
     routeName: TrendingScreen.routeName,
   ),
];