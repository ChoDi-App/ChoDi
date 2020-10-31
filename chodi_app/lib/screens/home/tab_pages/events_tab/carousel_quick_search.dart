import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:chodiapp/screens/home/tab_pages/events_tab/selection_cards/saved_card.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/selection_cards/calendar_card.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/selection_cards/nearby_card.dart';

class CarouselQuickSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselQuickSearchState();
  }
}

class _CarouselQuickSearchState extends State<CarouselQuickSearch> {
  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> qSearchCards = [SavedCard(),CalendarCard(),NearbyCard()];

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Quick Search",
                style: GoogleFonts.ubuntu(
                    fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 2.0,
              ),
            ],
          ),
        ),

        Container(
          height: 150.0,
          margin: EdgeInsets.symmetric(vertical: 20.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: qSearchCards.length,
              itemBuilder: (BuildContext context, int index) {
                return qSearchCards[index];
              })
        ),
      ],
    );
  }
}
