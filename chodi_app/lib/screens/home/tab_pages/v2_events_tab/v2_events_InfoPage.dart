import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/screens/home/ExpandingText.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_QRCodePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_image/firebase_image.dart';

import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:chodiapp/services/firestore.dart';

class v2_EventsInfoPage extends StatefulWidget {
  final Events event;
  v2_EventsInfoPage({@required this.event});

  @override
  _v2_EventsInfoPage createState() {
    return new _v2_EventsInfoPage();
  }
}

class _v2_EventsInfoPage extends State<v2_EventsInfoPage> {
  //_EventsInfoPage({@required this.event});
  //Events event;

  @override
  Widget build(BuildContext context) {
    Events event = widget.event;
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> favEventList = new List<Events>();
    List<Events> regEventList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);
    if (currentUser != null) {
      favEventList = updateSearchResults(eventsList, currentUser.savedEvents);
      regEventList =
          updateSearchResults(eventsList, currentUser.registeredEvents);

      // favEventList = eventsList.where((someEvent) {
      //   return currentUser.savedEvents.contains(someEvent.ein);
      // }).toList();
      //
      // regEventList = eventsList.where((someEvent) {
      //   return currentUser.registeredEvents.contains(someEvent.ein);
      // }).toList();
    }

    // TextStyles
    final textColor1 = Colors.black;
    final textColor2 = Colors.black87;
    final h1 =
        TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: textColor1);
    final h2 =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: textColor1);
    final h3 =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textColor2);
    final regText = TextStyle(fontSize: 16, height: 1.3, color: textColor2);
    final horizPadding = 25.0;
    final verticPadding = 20.0;
    final infoFieldSpacing = 35.0;

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
              initialChildSize: .40,
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
                            "View RSVP Information",
                            textAlign: TextAlign.center,
                            style: regText,
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

    Widget _RSVPButton() {
      if (regEventList.contains(event)) {
        return FloatingActionButton(
          heroTag: 3,
          backgroundColor: Colors.yellow[700],
          child: Icon(
            Icons.bookmark,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            // Link to QRCode page
            showOptions();
          },
        );
      } else if (event.registeredUsers.length >= event.maxCapacity) {
        return FloatingActionButton(
          heroTag: 3,
          backgroundColor: Colors.grey[400],
          child: Icon(
            Icons.bookmark_border,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            // SnackBar saying Capacity Reached
          },
        );
      } else {
        return FloatingActionButton(
          heroTag: 3,
          backgroundColor: Colors.yellow[700],
          child: Icon(
            Icons.bookmark_border,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            // 1) Check event availability
            //    - Size of registeredUsersList compared to maxCapacity
            // 2) Popup Dialog Box Confirming intent to RSVP
            // 3) Add to RegisteredList

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Registration",
                      style: h2,
                    ),
                    content: Text(
                      "There are ${event.maxCapacity - event.registeredUsers.length} spaces available.\n"
                      "Would you like to register?",
                      style: regText,
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          setState(() {
                            toggleRegistered(regEventList, currentUser, event);
                            Navigator.pop(context);
                          });
                        },
                      ),
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          },
        );
      }
    }

    Widget _FavoriteButton() {
      if (!favEventList.contains(event)) {
        return FloatingActionButton(
          heroTag: 1,
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            toggleLiked(favEventList, currentUser, event);
          },
        );
      } else {
        return FloatingActionButton(
          heroTag: 1,
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            toggleLiked(favEventList, currentUser, event);
          },
        );
      }
    }

    Widget _ShareButton() {
      return FloatingActionButton(
          heroTag: 0,
          backgroundColor: Colors.blueAccent[400],
          child: Icon(
            Icons.share,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              event.maxCapacity = 0;
            });

            // Implement Dynamic Link Sharing
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Event Details',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey),
        ),
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  // Header Container
                  Container(
                    height: 120,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        spreadRadius: 5,
                        offset: Offset(0, 10),
                      )
                    ]),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizPadding, vertical: verticPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.orgName, style: h2),
                          SizedBox(height: 5),
                          Text(event.eventName, style: h1),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),

                  // Features Container
                  Container(
                    height: 150,
                    color: Colors.grey[200],
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 150 + horizPadding,
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(width: horizPadding),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FadeInImage(
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            'images/loadingImage.gif'),
                                        image: FirebaseImage(event.imageURI ??
                                            "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: 300,
                          //color: Colors.lightBlue[400],
                        ),
                        Container(
                          height: double.infinity,
                          width: 300,
                          //color: Colors.lightBlue[500],
                        ),
                      ],
                    ),
                  ),

                  // Details Container
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizPadding, vertical: verticPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text('Description', style: h3),
                          SizedBox(height: 5),
                          ExpandingText(
                              validString(event.description), regText),
                          SizedBox(height: infoFieldSpacing),
                          Text('More Information: ', style: regText),
                          Linkify(
                            onOpen: (url) async {
                              if (await canLaunch(url.url)) {
                                await launch(url.url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            text: validString(event.eventURL),
                            style: GoogleFonts.ubuntu(fontSize: 15),
                          ),
                          SizedBox(height: infoFieldSpacing),
                          Text('Date', style: h3),
                          SizedBox(height: 5),
                          Text(validDate(event.eventDate), style: regText),
                          SizedBox(height: infoFieldSpacing),
                          Text('Time', style: h3),
                          SizedBox(height: 5),
                          Text(validTime(event.eventDate), style: regText),
                          SizedBox(height: infoFieldSpacing),
                          Text('Location', style: h3),
                          SizedBox(height: 5),
                          Text(validFullLocation(event.locationProperties),
                              style: regText),
                          SizedBox(height: infoFieldSpacing),
                          Container(
                            height: 225,
                            color: Colors.grey[400],
                            child: Center(child: Text('Map goes here.')),
                          ),
                          SizedBox(height: infoFieldSpacing),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: _FavoriteButton(),
          ),
          Positioned(
            right: 20,
            bottom: 110,
            child: _ShareButton(),
          ),
          Positioned(
            right: 20,
            bottom: 190,
            child: _RSVPButton(),
          ),
        ],
      ),
    );
  }

  String validString(String s) {
    if (s != null && s != "") return s;
    return "Not Available";
  }

  String validLocation(LocationProperties lp) {
    if (lp != null) {
      if (lp.city != null &&
          lp.city != "" &&
          lp.state != null &&
          lp.state != "")
        return '${lp.city}, ${lp.state}';
      else if (lp.state != null && lp.state != "")
        return '${lp.state}';
      else
        return "Location Not Available";
    }
    return "Location Not Available";
  }

  String validFullLocation(LocationProperties lp) {
    if (lp != null) {
      if (lp.address != null &&
          lp.address != "" &&
          lp.city != null &&
          lp.city != "" &&
          lp.state != null &&
          lp.state != "" &&
          lp.zip != null &&
          lp.zip != "" &&
          lp.country != null &&
          lp.country != "")
        return '${lp.address}\n${lp.city}, ${lp.state} ${lp.zip}\n${lp.country}';
      else if (lp.address != null &&
          lp.address != "" &&
          lp.city != null &&
          lp.city != "" &&
          lp.state != null &&
          lp.state != "" &&
          lp.zip != null &&
          lp.zip != "")
        return '${lp.address}\n${lp.city}, ${lp.state} ${lp.zip}';
      else
        return validLocation(lp);
    }
    return "Location Not Available";
  }

  String validDate(EventDate ed) {
    if (ed != null) {
      if (ed.startDate != "" && ed.endDate != "")
        return '${ed.startDate}  --  ${ed.endDate}';
      else if (ed.startDate != "") return ed.startDate;
    }
    return "Date Not Available";
  }

  String validTime(EventDate ed) {
    if (ed != null) {
      if (ed.startTime != "" && ed.endTime != "")
        return '${ed.startTime}  --  ${ed.endTime}';
      else if (ed.startTime != "") return ed.startTime;
    }
    return "Time Not Available";
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
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

  void toggleLiked(
      List<Events> moddedList, UserData currentUser, Events event) {
    try {
      if (moddedList.contains(event)) {
        setState(() {
          currentUser.savedEvents.remove(event.ein);
          FirestoreService(uid: currentUser.userId)
              .updateUserPreferences({"savedEvents": currentUser.savedEvents});
        });
      } else {
        setState(() {
          currentUser.savedEvents.add(event.ein);
          FirestoreService(uid: currentUser.userId)
              .updateUserPreferences({"savedEvents": currentUser.savedEvents});
        });
      }
    } catch (e) {
      print(e.toString());
    }
    return;
  }
}
