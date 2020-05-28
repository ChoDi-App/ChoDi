import 'package:chodiapp/models/events.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsCard extends StatelessWidget {
  Events event;

  EventsCard({@required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => NonProfitInfoPage(nonProfit: nonProfit)),
//      );
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
                    image: FirebaseImage(event.imageURI ??
                        "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
              color: Colors.black26,),
              Text(event.eventName,style: GoogleFonts.ubuntu(fontSize: 13),),
              Text("Date: ${event.eventDate.startDate} - ${event.eventDate.endDate}", style: GoogleFonts.ubuntu(fontSize: 10,fontWeight: FontWeight.w100))
            ],
          ),
        )
    ),
    );
  }
}
