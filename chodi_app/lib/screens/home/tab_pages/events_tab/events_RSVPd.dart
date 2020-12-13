import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_AgendaCalendar.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_Nav.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card_sm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/models/user.dart';

class RSVP extends StatefulWidget {
  String query;
  var sharedScrollController;

  RSVP({
    @required this.query,
    this.sharedScrollController,
  });

  @override
  _RSVP createState() => _RSVP();
}

class _RSVP extends State<RSVP> {
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> regEventList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);
    if (currentUser != null) {
      regEventList =
          updateSearchResults(eventsList, currentUser.registeredEvents);
    }
    List<Events> queryList = filterList(regEventList, widget.query);
    final double cardHeight = MediaQuery.of(context).size.height / 3;
    final double cardWidth = MediaQuery.of(context).size.width / 2;

    void showAgenda() {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: .95,
              maxChildSize: 1,
              minChildSize: .75,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return AgendaCalendar(scrollController: scrollController);
              },
            );
          });
    }

    if (regEventList.length < 1)
      return SafeArea(
        child: Center(
          child: Text(
            "No registered events.",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
          ),
        ),
      );
    else if (widget.query == "") {
      return (SafeArea(
        child: Container(
          child: ListView(
            controller: widget.sharedScrollController,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    )
                  ],
                  color: Colors.orange[400],
                ),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    "Agenda",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    showAgenda();
                  },
                ),
              ),
              if (regEventList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    (regEventList.length > 1)
                        ? ("Displaying ${regEventList.length} registered events.")
                        : ("Displaying 1 registered event. "),
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: (GridView.builder(
                  itemCount: regEventList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (cardWidth / cardHeight),
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return EventCard_sm(
                      event: regEventList[index],
                      cardHeight: cardHeight,
                    );
                  },
                )),
              )
            ],
          ),
        ),
      ));
    } else
      return (SafeArea(
        child: Container(
          child: ListView(
            controller: widget.sharedScrollController,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
              (Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                //child: Text("Displaying events nearby: $location",
                child: Text(
                  (regEventList.length > 1)
                      ? ("Displaying ${queryList.length} registered results for '${widget.query}'")
                      : ("Displaying 1 registered result for '${widget.query}'"),
                  style: GoogleFonts.ubuntu(
                      fontSize: 15, fontWeight: FontWeight.normal),
                ),
              )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: (GridView.builder(
                  itemCount: queryList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (cardWidth / cardHeight),
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return EventCard_sm(
                      event: queryList[index],
                      cardHeight: cardHeight,
                    );
                  },
                )),
              )
            ],
          ),
        ),
      ));
  }

  // Auxiliary Functions
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

  List<Events> updateSearchResults(List<Events> eventsList, var einSaved) {
    List<Events> savedList = new List<Events>();
    for (var i = 0; i < eventsList.length; i++) {
      for (var j = 0; j < einSaved.length; j++) {
        if (eventsList[i].ein == einSaved[j]) {
          savedList.add(eventsList[i]);
          break;
        }
      }
    }
    return savedList;
  }
}
