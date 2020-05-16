import 'package:chodiapp/models/non_profit.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatefulWidget {
  NonProfit nonProfit;
  SearchResultTile({this.nonProfit});
  @override
  _SearchResultTileState createState() => _SearchResultTileState();
}

class _SearchResultTileState extends State<SearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Container(
              width: 72.0,
              height: 72.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('images/loadingImage.gif'),
                  image: FirebaseImage(widget.nonProfit.imageURI ??
                      "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
                ),
              ),
            ),
            title: Text(widget.nonProfit.name),
            subtitle: Text(widget.nonProfit.cause),
          ),
        )
      ],
    );
  }
}
