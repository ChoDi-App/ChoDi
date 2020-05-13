import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/screens/Home/tab_pages/for_you_tab/for_you_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: primaryColor,
      ),
      body: Center(),
    );
  }
}
