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
  TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: appBarColor,
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: Column(
        children: <Widget>[
          _buildFilter(),
          Container(
            height: 5,
            color: backgroundColor,
          ),
          _buildListResults()
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black38)),
                onPressed: () {},
                child: Text(
                  "See All Filters",
                  style: TextStyle(fontSize: 14, color: Colors.black38),
                )),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "Sort by:",
                    style: TextStyle(color: Colors.black38),
                  ),
                  Text(
                    "Change to dropdown",
                    style: TextStyle(color: Colors.black38),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildListResults() {
    List<NonProfit> nonProfitsData = Provider.of<List<NonProfit>>(context);

    return Flexible(
        child: ListView.builder(
            itemCount: nonProfitsData.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return SearchResultTile(
                nonProfit: nonProfitsData[index],
              );
            }));
  }

  Widget _buildSearchField() {
    return Container(
      child: TextField(
        controller: _searchQueryController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search Non-profit Organizations",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black38),
        ),
        style: TextStyle(color: Colors.black54, fontSize: 16.0),
        onChanged: (query) => updateSearchQuery,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 38,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (_searchQueryController == null ||
              _searchQueryController.text.isEmpty) {
            Navigator.pop(context);
            return;
          }
          _clearSearchQuery();
        },
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {});
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {});
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
