import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/models/non_profit.dart';
import 'package:chodiapp/screens/Home/search_page/search_result_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    List<NonProfit> nonProfitsData = Provider.of<List<NonProfit>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemCount: nonProfitsData.length,
        itemBuilder: (BuildContext context, int index) {
          return SearchResultTile(
            nonProfit: nonProfitsData[index],
          );
        },
      ),
    );
  }
}
