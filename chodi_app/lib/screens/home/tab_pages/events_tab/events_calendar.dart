import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsCalendarPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> moddedList = new List<Events>();
    moddedList = timeSorting(eventsList);

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
                  child: Text("Calendar",
                    style:
                    GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                if(true)(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      //child: Text("Displaying events nearby: $location",
                      child: Text("Displaying events in chronological order",
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

  //Modify list based on dates
  List<Events> timeSorting(List<Events> eventsList){
    List<Events> moddedList = new List<Events>();

    eventsList.sort((a, b) => a.numericSDate.compareTo(b.numericSDate));
    moddedList = eventsList;

    return moddedList;
  }
}