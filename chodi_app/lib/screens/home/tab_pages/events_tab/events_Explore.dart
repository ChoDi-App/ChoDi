import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_Nav.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card_lg.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatefulWidget {
  String query;
  List<searchFilterChip> filters;

  ExplorePage({@required this.query, this.filters});

  @override
  _ExplorePage createState() => _ExplorePage();
}

class _ExplorePage extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);

    // List<Events> eventsList = (widget.filters == null)
    //     ? Provider.of<List<Events>>(context)
    //     : filterListWithChips(
    //         Provider.of<List<Events>>(context), widget.filters);

    List<Events> queryList = filterList(eventsList, widget.query);

    if (widget.query == "")
      return SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
              if (eventsList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    "Displaying all ${eventsList.length} events. ",
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )),
              ListView.builder(
                itemCount: eventsList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return EventCard_lg(
                    event: eventsList[index],
                  );
                },
              ),
            ],
          ),
        ),
      );
    else
      return SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
              if (eventsList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    (queryList.length > 1)
                        ? ("Displaying ${queryList.length} results for '${widget.query}'.")
                        : ("Displaying ${queryList.length} result for '${widget.query}'."),
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )),
              ListView.builder(
                itemCount: queryList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return EventCard_lg(
                    event: queryList[index],
                  );
                },
              ),
            ],
          ),
        ),
      );
  }

  List<Events> filterList(List<Events> someList, String someQuery) {
    return someList.where((someEventInList) {
      var theQuery = someQuery.toLowerCase();
      var eventTitle = someEventInList.eventName.toLowerCase();
      var eventOrg = someEventInList.organizationName.toLowerCase();
      var eventCity = someEventInList.locationProperties.city.toLowerCase();
      var eventState = someEventInList.locationProperties.state.toLowerCase();
      var eventCat = someEventInList.category.toLowerCase();
      return (eventTitle.contains(theQuery) ||
          eventOrg.contains(theQuery) ||
          eventCity.contains(theQuery) ||
          eventState.contains(theQuery) ||
          eventCat.contains(theQuery));
    }).toList();
  }
}
