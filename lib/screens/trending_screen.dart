import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trending.dart';
import './favourite_detail_screen.dart';
import '../widgets/movie_list.dart';

class TrendingScreen extends StatelessWidget {
  static const routeName = './trendingScreen';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Today!!'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<Trending>(context, listen: false).getTrendingMovies(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Trending>(
                    builder: (ctx, list, _) => ListWidget(list.trend,false,false),
                  ),
      ),
    );
  }
}
