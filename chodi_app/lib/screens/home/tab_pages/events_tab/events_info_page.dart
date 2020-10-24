import 'package:chodiapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_image/firebase_image.dart';

import 'package:chodiapp/models/events.dart';

class EventsInfoPage extends StatelessWidget {
  EventsInfoPage({@required this.event});

  Events event;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHODI",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            event.eventName,
                            style: GoogleFonts.ubuntu(
                                fontSize: 22, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                          ),
                          width: deviceWidth / 1.3,
                        ),
                        Icon(
                          Icons.favorite_border,
                          size: 40,
                        )
                      ],
                    ),
                    Text(event.eventContactEmail),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex:1,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage('images/loadingImage.gif'),
                            image: FirebaseImage(event.imageURI),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              /*
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  //Text("Location: ${event.location}")
                                  Text("Location: **CHAR OVERFLOW**")
                                ],
                              ),
                               */
                              Row(
                                children: <Widget>[
                                  Icon(Icons.category),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text("Categories: (${event.category})",
                                      softWrap: true,
                                      overflow: TextOverflow.clip,),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Start Date: ${event.eventDate.startDate}")
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("End Date: ${event.eventDate.endDate}")
                                ],
                              ),
                              if(event.eventDate.startTime.isNotEmpty)(
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Start Time: ${event.eventDate.startTime}")
                                ],
                              )),
                              if(event.eventDate.endTime.isNotEmpty)(
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("End Time: ${event.eventDate.endTime}")
                                ],
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {},
                          child: Text("DONATE"),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text("MESSAGE"),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text("EMAIL"),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Location",
                            style: GoogleFonts.ubuntu(
                                fontSize: 17, color: Colors.black),
                          ),
                          Text(
                            event.location,
                            style:
                            GoogleFonts.ubuntu(fontWeight: FontWeight.w100),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          if(event.eventURL.isNotEmpty)(
                          Text(
                            "Website",
                            style: GoogleFonts.ubuntu(
                                fontSize: 17, color: Colors.black),
                          )),
                          if(event.eventURL.isNotEmpty)(
                          Linkify(
                            onOpen: (url) async {
                              if (await canLaunch(url.url)) {
                                await launch(url.url);
                              } else {
                                throw 'Could not luanch $url';
                              }
                            },
                            text: event.eventURL,
                            style: GoogleFonts.ubuntu(fontSize: 15),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
