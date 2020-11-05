import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/models/user.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class EventsNearbyPage extends StatefulWidget {
  @override
  _EventsNearbyPage createState() {
    return new _EventsNearbyPage();
  }
}

class _EventsNearbyPage extends State<EventsNearbyPage>{
  bool permissionError = false;

  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> moddedList = new List<Events>();
    //UserData currentUser = Provider.of<UserData>(context);
    geoSorting(eventsList).then((val) => setState(() {
      moddedList = val;
    }));

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

            if(permissionError)(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Error occurred in location access, please configure user settings",
                    style:
                    GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )
            ),

            if(!permissionError)(
              Padding(
                padding: const EdgeInsets.all(8.0),
                //child: Text("Displaying events nearby: $location",
                child: Text("Displaying events nearby you",
                style:
                GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              )
            ),

            if(moddedList.length > 0 && !permissionError)(
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
  Future<List<Events>> geoSorting(List<Events> eventsList) async{
    List<Events> moddedList = new List<Events>();
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      permissionError = true;
      return moddedList;
    }

    //Meters threshold for considering events as nearby
    //50,0000 meters = 31 miles
    var maxDist = 50080;
    Position selfCord = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

    for (var i=0; i<eventsList.length; i++) {
      var current = eventsList[i].location;
      if(current.toLowerCase() == "NOT AVAILABLE".toLowerCase())
        continue;

      var addresses = await Geocoder.local.findAddressesFromQuery(current);
      var eventCord = addresses.first.coordinates;

      if(Geolocator.distanceBetween(selfCord.latitude, selfCord.longitude,
          eventCord.latitude, eventCord.longitude) <= maxDist){
        moddedList.add(eventsList[i]);
      }
    }
    return moddedList;
  }
}