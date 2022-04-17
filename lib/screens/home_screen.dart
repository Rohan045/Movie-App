import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import '../widgets/home_widget.dart';
import '../option.dart';


class HomeScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('The Movie App'),),
      drawer: AppDrawer(),
      body: GridView.builder(
        padding: EdgeInsets.all(25),
        itemCount: optionCategory.length,
        itemBuilder: (ctx, i) => HomeWidget(
          color: optionCategory[i].color,
          title: optionCategory[i].title,
          routeName: optionCategory[i].routeName,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 20,
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}