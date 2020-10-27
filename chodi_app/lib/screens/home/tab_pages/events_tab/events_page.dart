import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carousel_quick_search.dart';
import 'events_page_mk0.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CarouselQuickSearch(),
          Divider(
            thickness: 0.5,
            color: Colors.black38,
          ),
          EventsPage0(),
        ],
      ),
    );
  }
}
