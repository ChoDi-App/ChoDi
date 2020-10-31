import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/models/user.dart';

class EventsNearbyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> moddedList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);
    var location = "";
    if(currentUser != null){
      location = currentUser.zipCode;
      moddedList = updateSearchResults(eventsList);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHODI",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Nearby",
                style:
                GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            if(location != "")(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Displaying events nearby: $location",
                style:
                GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              )
            )
            else(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No location registered, please configure user settings",
                style:
                GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              )
            ),

            if(moddedList.length > 0)(
              Column(
                children: <Widget>[
                  GridView.builder(
                    itemCount: moddedList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return EventsCard(
                        event: moddedList[index],
                      );
                    },
                  ),
                ],
              )
            )
          ]
        ),
      )
    );
  }

  //Modify list based on location
  List<Events> updateSearchResults(var eventsList) {
    //INSERT CODE HERE////////////////////////////////////////////////////
      //
    //////////////////////////////////////////////////////////////////////
    return eventsList;
  }
}