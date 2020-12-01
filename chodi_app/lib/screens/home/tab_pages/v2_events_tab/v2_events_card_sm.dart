import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_QRCodePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/models/user.dart';
import 'package:provider/provider.dart';
import 'v2_events_InfoPage.dart';

class v2_EventCard_sm extends StatefulWidget {
  //Each EventCard has a corresponding 'event'
  Events event;
  double cardHeight;
  //EventCard Constructor requires an 'event'
  v2_EventCard_sm({@required this.event, @optionalTypeArgs this.cardHeight});

  @override
  _v2_EventCard_sm createState() => _v2_EventCard_sm();
}

class _v2_EventCard_sm extends State<v2_EventCard_sm> {
  @override
  Widget build(BuildContext context) {
    Events event = widget.event;
    UserData currentUser = Provider.of<UserData>(context);
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> regEventList = new List<Events>();
    if (currentUser != null) {
      regEventList =
          updateSearchResults(eventsList, currentUser.registeredEvents);
    }

    final textColor1 = Colors.black;
    final textColor2 = Colors.black87;
    var h1 = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: textColor1);
    var h2 = TextStyle(fontSize: 14, color: textColor2);
    final regText = TextStyle(fontSize: 14, height: 1.3, color: textColor2);

    void showRSVPInfo() {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: .95,
              maxChildSize: 1,
              minChildSize: .80,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return v2_QRCodePage(
                    event: event, scrollController: scrollController);
              },
            );
          });
    }

    void showOptions() {
      showModalBottomSheet(
          isDismissible: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: .60,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.red,
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child: Text(
                              "Cancel RSVP",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Cancel RSVP",
                                        style: h2,
                                      ),
                                      content: Text(
                                        "Are you sure you want to cancel this registration?",
                                        style: regText,
                                      ),
                                      actions: [
                                        FlatButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            setState(() {
                                              toggleRegistered(regEventList,
                                                  currentUser, event);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          child: Text(
                            "View Event Details",
                            textAlign: TextAlign.center,
                            style: h1,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      v2_EventsInfoPage(event: event)),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          child: Text(
                            "View RSVP Information",
                            textAlign: TextAlign.center,
                            style: h1,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            showRSVPInfo();
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          });
    }

    return GestureDetector(
      onTap: () {
        if (currentUser == null) {
          Navigator.of(context).pushNamed('signInScreen');
        } else {
          showRSVPInfo();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
        child: Container(
          // Height wont matter due to childAspectRatio in grid on RSVP page
          height: 250.0,

          // Clip items inside to rounded edges of Card
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      //color: Colors.deepPurple[400],
                      padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            validString(event.eventName),
                            style: h1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Text(
                            validStartDate(event.eventDate),
                            style: h2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Text(
                            validLocation(event.locationProperties),
                            style: h2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      //color: Colors.deepPurple[300],
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FadeInImage(
                                    width: widget.cardHeight / 3.25,
                                    height: widget.cardHeight / 3.25,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        AssetImage('images/loadingImage.gif'),
                                    image: FirebaseImage(event.imageURI ??
                                        "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
                                  ),
                                ),
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         color: Colors.grey[300], width: 2),
                                //     borderRadius: BorderRadius.circular(100)),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey[400],
                              size: 35,
                            ),
                            onTap: () {
                              showOptions();
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
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

  String validString(String s) {
    if (s != null)
      return s;
    else
      return "Not Available";
  }

  String validDescription(String s) {
    if (s != null && s != "")
      return s;
    else
      return "(Description is not available, please update the database)";
  }

  String validLocation(LocationProperties lp) {
    if (lp != null) {
      if (lp.city != "" && lp.state != "")
        return '${lp.city}, ${lp.state}';
      else if (lp.state != "")
        return '${lp.state}';
      else
        return "Location Unavailable";
    } else
      return "Location Unavailable";
  }

  String validStartDate(EventDate ed) {
    if (ed != null) {
      if (ed.startDate != "")
        return '${ed.startDate}';
      else
        return "Date Not Available";
    }
    return "Date Not Available";
  }
}
