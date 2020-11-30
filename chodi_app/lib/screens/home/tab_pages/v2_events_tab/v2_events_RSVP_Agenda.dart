import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_RSVPd.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_card_sm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/models/user.dart';

/*
  This File will replace RSVPd page, when fully implemented.
  The difference is an 'Agenda' button that is attached below
  the tab bar navigator. Button should always remain in view,
  and scrolling within TabView should still collapse portion
  above the tab bar navigator (meaning the search bar or
  AppBar title).
*/

class v2_RSVP_Agenda extends StatefulWidget {
  String givenQuery;
  var sharedScrollController;

  v2_RSVP_Agenda(this.givenQuery,
      {@optionalTypeArgs this.sharedScrollController});

  @override
  _v2_RSVP_Agenda createState() => _v2_RSVP_Agenda();
}

class _v2_RSVP_Agenda extends State<v2_RSVP_Agenda> {
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> regEventList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);
    if (currentUser != null) {
      regEventList =
          updateSearchResults(eventsList, currentUser.registeredEvents);
    }
    List<Events> queryList = filterList(regEventList, widget.givenQuery);
    final double cardHeight = MediaQuery.of(context).size.height / 3;
    final double cardWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.grey[300],
        title: Text(
          'Agenda',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: v2_RSVP(
        widget.givenQuery,
        sharedScrollController: widget.sharedScrollController,
      ),
    );
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
    else if (widget.givenQuery == "") {
      return (SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
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
                    return v2_EventCard_sm(
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
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
              if (regEventList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    (regEventList.length > 1)
                        ? ("Displaying ${queryList.length} registered results for '${widget.givenQuery}'")
                        : ("Displaying 1 registered result for '${widget.givenQuery}'"),
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
                    return v2_EventCard_sm(
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
      var eventOrg = someEventInList.orgName.toLowerCase();
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
