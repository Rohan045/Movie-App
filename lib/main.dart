import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/trending_screen.dart';
import './screens/top10_screen.dart';
import './providers/trending.dart';
import './screens/history_screen.dart';
import './screens/auth_Screen.dart';
import './screens/home_screen.dart';
import './providers/auth.dart';
import './screens/favourites_screen.dart';
import '../providers/favourites.dart';
import './screens/search_screen.dart';
import './providers/searched_movie.dart';
import './screens/splash_screen.dart';
import './screens/favourite_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Favourites>(
          create: (ctx) => Favourites('', '', []),
          update: (
              ctx,
              auth,
              previousMovies,
              ) =>
              Favourites(auth.token, auth.userId,previousMovies!.favouriteMovies),
        ),
        ChangeNotifierProxyProvider<Auth, Favourites>(
          create: (ctx) => Favourites('', '', []),
          update: (
            ctx,
            auth,
            previousMovies,
          ) =>
              Favourites(auth.token, auth.userId,previousMovies!.favouriteMovies),
        ),
        ChangeNotifierProvider.value(
          value: Trending(),
        ),
        ChangeNotifierProvider.value(
          value: MovieList(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Movie App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            SearchScreen.routeName: (ctx) => SearchScreen(),
            FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
            FavouriteDetailsScreen.routeName: (ctx) => FavouriteDetailsScreen(),
            Top10Screen.routeName: (ctx) => Top10Screen(),
            TrendingScreen.routeName: (ctx) => TrendingScreen(),
          },
        ),
      ),
    );
  }
}
