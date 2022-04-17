import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/favourite_detail_screen.dart';
import '../providers/favourites.dart';

class ListWidget extends StatelessWidget {
  final bool? dismiss;
  final bool? numbering;
  final List<dynamic> list;

  ListWidget(
    this.list,
    this.numbering,
    this.dismiss,
  );

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx, i) => InkWell(
          onTap: () => Navigator.of(context).pushNamed(
              FavouriteDetailsScreen.routeName,
              arguments: list[i].title!),
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          child: dismiss!
              ? Dismissible(
                  direction: DismissDirection.endToStart,
                  key: ValueKey(list[i].title!),
                  onDismissed: (direction) {
                    Provider.of<Favourites>(context, listen: false)
                        .removeFav(list[i].title!);
                  },
                  background: Container(
                    color: Theme.of(context).errorColor,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  ),
                  child: Card(
                    //color: Colors.grey.withOpacity(0.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        list[i].posterUrl == 'N/A'
                            ? Container(
                                width: 150,
                                height: 150,
                                child: Center(
                                  child: Text('N/A'),
                                ),
                              )
                            : Container(
                                width: 150,
                                height: 150,
                                child: Image.network(list[i].posterUrl!),
                              ),
                        Expanded(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  numbering! ? Text('${i + 1}') : Text(''),
                                  Text(
                                    list[i].title!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'IMDB Rating - ${list[i].rating!}',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Card(
                  //color: Colors.grey.withOpacity(0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      list[i].posterUrl == 'N/A'
                          ? Container(
                              width: 150,
                              height: 150,
                              child: Center(
                                child: Text('N/A'),
                              ),
                            )
                          : Container(
                              width: 150,
                              height: 150,
                              child: Image.network(list[i].posterUrl!),
                            ),
                      Expanded(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                numbering! ? Text('${i + 1}') : Text(''),
                                Text(
                                  list[i].title!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'IMDB Rating - ${list[i].rating!}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
