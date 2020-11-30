import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:chodiapp/services/firestore.dart';
import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/models/user.dart';
import 'package:provider/provider.dart';
import 'v2_events_InfoPage.dart';

class v2_EventCard_lg extends StatefulWidget {
  //Each EventCard has a corresponding 'event'
  Events event;

  //EventCard Constructor requires an 'event'
  v2_EventCard_lg({@required this.event});

  @override
  _v2_EventCard_lg createState() => _v2_EventCard_lg();
}

class _v2_EventCard_lg extends State<v2_EventCard_lg> {
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
    }

    var h1 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
    var h2 = TextStyle(fontSize: 16);
    var p = TextStyle(fontSize: 14, height: 1.5);

    return GestureDetector(
      onTap: () {
        if (currentUser == null) {
          Navigator.of(context).pushNamed('signInScreen');
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => v2_EventsInfoPage(event: event)),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          height: 250.0,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            // Clip items inside to rounded edges of Card
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Expanded(
                      flex: 15,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    //color: Colors.deepPurpleAccent,
                                    child: Padding(
                                      padding: EdgeInsets.all(25),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: FadeInImage(
                                          fit: BoxFit.cover,
                                          placeholder: AssetImage(
                                              'images/loadingImage.gif'),
                                          image: FirebaseImage(event.imageURI),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      //color: Colors.deepPurple,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 0, 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            validString(event.eventName),
                                            style: h1,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            validString('organization_name'),
                                            style: h2,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            validLocation(
                                                event.locationProperties),
                                            style: h2,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                //color: Colors.limeAccent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                child: Text(
                                  validDescription(event.description),
                                  style: p,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                        //color: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Registered Icon properties
                            if (regEventList.contains(event))
                              GestureDetector(
                                child: (Icon(
                                  Icons.bookmark,
                                  color: Colors.yellow[600],
                                  size: 35,
                                )),
                                onTap: () {},
                              ),
                            //Heart icon properties
                            SizedBox(height: 10),
                            if (currentUser == null)
                              (GestureDetector(
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.grey[300],
                                  size: 35,
                                ),
                                onTap: () {},
                              ))
                            else if (favEventList.contains(event))
                              (GestureDetector(
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                  size: 35,
                                ),
                                onTap: () {
                                  toggleFavorite(
                                      favEventList, currentUser, event);
                                },
                              ))
                            else
                              (GestureDetector(
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey[300],
                                  size: 35,
                                ),
                                onTap: () {
                                  toggleFavorite(
                                      favEventList, currentUser, event);
                                },
                              )),
                          ],
                        ),
                      ))
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

  void toggleFavorite(
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
