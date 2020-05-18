import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/models/non_profit.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchResultTile extends StatefulWidget {
  NonProfit nonProfit;

  SearchResultTile({this.nonProfit});

  @override
  _SearchResultTileState createState() => _SearchResultTileState();
}

class _SearchResultTileState extends State<SearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: <Widget>[
          Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _imageSection(),
                Flexible(child: _infoSection())
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageSection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 130.0,
            height: 100.0,
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
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
            child: Text(
              "Location:",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
            child: Text(
              widget.nonProfit.address.city +
                  ", " +
                  widget.nonProfit.address.state,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, right: 12),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        widget.nonProfit.name,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        widget.nonProfit.cause,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                )
              ),
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.favorite_border, color: Colors.black38,),
                  onPressed: () {
                  },
                ),
                width: 20,
                height: 20,
              )
            ],
          ),
          Text(
            widget.nonProfit.missionVision,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
