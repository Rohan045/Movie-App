import 'package:flutter/material.dart';

import './favourite_detail_screen.dart';
import '../top10.dart';
import '../widgets/movie_list.dart';

class Top10Screen extends StatelessWidget {
  static const routeName = './top10Screen';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top 10 Rated Movies'),
      ),
      body: ListWidget(top, true, false),
    );
  }
}
