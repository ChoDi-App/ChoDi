import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/models/user.dart';

class EventsSavedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> moddedList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);
    if(currentUser != null){
      moddedList = updateSearchResults(eventsList, new List<String>());//currentUser.einSaved);
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
                  child: Text("Saved",
                    style:
                    GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                if(true)(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      //child: Text("Displaying events nearby: $location",
                      child: Text("Displaying events you recently favorited",
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

  List<Events> updateSearchResults(List<Events> eventsList, var einSaved) {
    List<Events> nearList = new List<Events>();
    for (var i=0; i<eventsList.length; i++) {
      for (var j=0; j<einSaved.length; j++){
        if(eventsList[i].ein == einSaved[j]){
          nearList.add(eventsList[i]);
          break;
        }
      }
    }
    return nearList;
  }
}