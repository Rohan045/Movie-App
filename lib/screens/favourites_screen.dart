import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favourites.dart';
import '../screens/favourite_detail_screen.dart';
import '../widgets/movie_list.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = './favourite-screen';

  Future<void> _getFav(context) async {
    await Provider.of<Favourites>(context, listen: false).fetchAndSetMovies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favourite Movies!!'),
      ),
      body: FutureBuilder(
        future: _getFav(context),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Favourites>(
                builder: (ctx, list, _) => ListWidget(list.favouriteMovies, false, true),
              ),
      ),
    );
  }
}
