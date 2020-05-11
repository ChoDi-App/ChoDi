import 'package:chodiapp/Models/user.dart';
import 'package:chodiapp/Models/non_profit.dart';
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
    List<NonProfit> nonProfitsData =
        Provider.of<List<NonProfit>>(context) ?? [];

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
