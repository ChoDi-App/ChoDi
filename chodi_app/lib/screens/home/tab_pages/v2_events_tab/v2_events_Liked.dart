import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_card_lg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/models/user.dart';

class v2_Liked extends StatefulWidget {
  String givenQuery;

  v2_Liked(this.givenQuery);

  @override
  _v2_Liked createState() => _v2_Liked();
}

class _v2_Liked extends State<v2_Liked> {
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> favEventList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);
    if (currentUser != null) {
      favEventList = updateSearchResults(eventsList, currentUser.savedEvents);
    }
    List<Events> queryList = filterList(favEventList, widget.givenQuery);

    if (favEventList.length < 1)
      return SafeArea(
        child: Center(
          child: Text(
            "No liked events.",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
          ),
        ),
      );
    else if (widget.givenQuery == "")
      return (SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
              if (favEventList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    (favEventList.length > 1)
                        ? ("Displaying ${favEventList.length} liked events.")
                        : ("Displaying 1 liked event. "),
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )),
              (ListView.builder(
                itemCount: favEventList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return v2_EventCard_lg(
                    event: favEventList[index],
                    showDistance: false,
                  );
                },
              ))
            ],
          ),
        ),
      ));
    else
      return (SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
              if (favEventList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    (favEventList.length > 1)
                        ? ("Displaying ${queryList.length} liked results for '${widget.givenQuery}'")
                        : ("Displaying 1 liked result for '${widget.givenQuery}'"),
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )),
              (ListView.builder(
                itemCount: queryList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return v2_EventCard_lg(
                    event: queryList[index],
                    showDistance: false,
                  );
                },
              ))
            ],
          ),
        ),
      ));
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
