import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_card_lg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/models/user.dart';

class v2_Liked extends StatefulWidget {
  @override
  _v2_Liked_State createState() => _v2_Liked_State();
}

class _v2_Liked_State extends State<v2_Liked> {
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> moddedList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);
    if (currentUser != null) {
      moddedList = updateSearchResults(eventsList, currentUser.einSaved);
    }

    return (moddedList.length < 1)
        ? SafeArea(
            child: Center(
              child: Text(
                "No liked events.",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
          )
        : SafeArea(
            child: Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 50),
                  if (moddedList.length > 0)
                    (Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                      //child: Text("Displaying events nearby: $location",
                      child: Text(
                        (moddedList.length > 1)
                            ? ("Displaying ${moddedList.length} liked events.")
                            : ("Displaying ${moddedList.length} liked event "),
                        style: GoogleFonts.ubuntu(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    )),
                  (ListView.builder(
                    itemCount: moddedList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return v2_EventCard_lg(
                        event: moddedList[index],
                      );
                    },
                  ))
                ],
              ),
            ),
          );
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
