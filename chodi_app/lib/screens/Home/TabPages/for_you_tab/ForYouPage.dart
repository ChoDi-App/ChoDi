import 'package:chodiapp/models/User.dart';
import 'package:chodiapp/models/non_profits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'non_profit_tile.dart';

class ForYouPage extends StatefulWidget {
  @override
  _ForYouPageState createState() => _ForYouPageState();
}



class _ForYouPageState extends State<ForYouPage> {
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context) ?? UserData();
    List<NonProfitsData> nonProfitsData =
        Provider.of<List<NonProfitsData>>(context) ?? [];

    return Container(
      child: ListView.builder(
        itemCount: nonProfitsData.length,
        itemBuilder: (BuildContext context, int index) {
          return NonProfitTile(nonProfit: nonProfitsData[index]);
        },
      ),
    );
  }
}
