import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_calendar.dart';

class CalendarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute( builder: (context) => EventsCalendarPage()),
        );
      },
      child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('images/loadingImage.gif'),
                      image: FirebaseImage("gs://chodi-663f2.appspot.com/eventcardlogos/Calendar.png" ??
                          "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
                    ),
                  ),
                ),
                Text("Calendar",style: GoogleFonts.ubuntu(fontSize: 13),),
              ],
            ),
          )
      ),
    );
  }
}