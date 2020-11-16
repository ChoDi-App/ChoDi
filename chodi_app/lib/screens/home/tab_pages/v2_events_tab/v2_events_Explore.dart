import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_card_lg.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class v2_ExplorePage extends StatefulWidget {
  @override
  _v2_ExplorePageState createState() => _v2_ExplorePageState();
}

class _v2_ExplorePageState extends State<v2_ExplorePage> {
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);

    return Container(
      child: ListView.builder(
        itemCount: eventsList.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return v2_EventCard_lg(
            event: eventsList[index],
          );
        },
      ),
      // child: GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 1,
      //   ),
      //   itemCount: eventsList.length,
      //   //itemCount: eList.length,
      //   shrinkWrap: true,
      //   physics: ScrollPhysics(),
      //   itemBuilder: (BuildContext context, int index) {
      //     return EventsCard(
      //       event: eventsList[index],
      //     );
      //     //return eList[index];
      //   },
      // ),
    );
  }
}
