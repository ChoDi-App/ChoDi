import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/models/non_profit.dart';
import 'package:chodiapp/screens/Home/search_page/search_result_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'filter_result.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = "";
  List<NonProfit> listNonProfits = new List<NonProfit>();
  List<NonProfit> filteredNonProfits = new List<NonProfit>();

  @override
  void initState() {
    filteredNonProfits.addAll(listNonProfits);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listNonProfits = Provider.of<List<NonProfit>>(context);

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
          _buildListResults(filteredNonProfits)
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
                onPressed: () {
                  _editFilterBottomSheet(context);
                },
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

  Widget _buildListResults(List<NonProfit> results) {

    return Flexible(
        child: ListView.builder(
            itemCount: results.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return SearchResultTile(
                nonProfit: results[index],
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
        onChanged: (query) {
          searchQuery = query;
          updateSearchResults();
        },
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
//          if (_searchQueryController == null ||
//              _searchQueryController.text.isEmpty) {
//            Navigator.pop(context);
//            return;
//          }
          _clearSearchQuery();
        },
      ),
    ];
  }

  void updateSearchResults() {
    List<NonProfit> temp = new List<NonProfit>();

    if (searchQuery.isNotEmpty) {
      listNonProfits.forEach((nonProfit) {
        if (nonProfit.name.contains(new RegExp(searchQuery, caseSensitive: false)) |
        nonProfit.missionVision.contains(new RegExp(searchQuery, caseSensitive: false)) |
        nonProfit.cause.contains(new RegExp(searchQuery, caseSensitive: false)) |
        nonProfit.category.contains(new RegExp(searchQuery, caseSensitive: false)) |
        nonProfit.address.city.contains(new RegExp(searchQuery, caseSensitive: false)) |
        nonProfit.address.state.contains(new RegExp(searchQuery, caseSensitive: false))){
          temp.add(nonProfit);
        }
      });
      setState(() {
        filteredNonProfits.clear();
        filteredNonProfits.addAll(temp);
      });

    } else {
      temp = listNonProfits;
      setState(() {
        filteredNonProfits.clear();
        filteredNonProfits.addAll(listNonProfits);
      });
    }
  }


  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      filteredNonProfits.clear();
      filteredNonProfits.addAll(listNonProfits);
    });
  }

  void _editFilterBottomSheet (context) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height * .60,
        child: FilterResult()
      );
    });
  }

}

