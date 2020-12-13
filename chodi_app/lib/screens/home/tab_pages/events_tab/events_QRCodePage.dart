import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/services/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/models/user.dart';
import 'package:provider/provider.dart';

class QRCodePage extends StatelessWidget {
  final Events event;
  var scrollController;
  QRCodePage({@required this.event, this.scrollController});

  @override
  Widget build(BuildContext context) {
    UserData currentUser = Provider.of<UserData>(context);

    // TextStyles
    final textColor1 = Colors.black;
    final textColor2 = Colors.black87;
    final h1 =
        TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: textColor1);
    final h2 =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: textColor1);
    final h3 =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor2);
    final regText = TextStyle(fontSize: 14, height: 1.3, color: textColor2);
    final infoFieldSpacing = 35.0;

    return SafeArea(
      child: ListView(controller: scrollController, children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Container
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.expand_more_rounded,
                          size: 50,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(height: 20),
                      Text(event.organizationName, style: h2),
                      SizedBox(height: 5),
                      Text(event.eventName, style: h1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 6 / 11,
                          height: MediaQuery.of(context).size.width * 6 / 11,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: QrImage(
                                data: event.getSecretString(currentUser),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text('Volunteer', style: h2),
                      SizedBox(height: 5),
                      Text(currentUser.name, style: h1),
                      //Text(event.ein),
                      //Text(currentUser.userId),
                      SizedBox(height: 25),
                      Text('Ticket/Seating', style: h2),
                      SizedBox(height: 5),
                      Text('General', style: h1),
                    ],
                  ),
                ),

                SizedBox(height: 50),
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
                // Details Container
              ],
            ),
          ),
        ),
      ]),
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
}

void toggleRegistered(
    List<Events> regList, UserData currentUser, Events event) {
  try {
    if (regList.contains(event)) {
      event.unregisterUser(currentUser);
      currentUser.unregisterEvent(event.ein);
      FirestoreService(uid: currentUser.userId).updateUserPreferences(
          {"registeredEvents": currentUser.registeredEvents});
      FirestoreService(ein: event.ein)
          .updateEventPreferences({"registeredUsers": event.registeredUsers});
    } else {
      event.registerUser(currentUser);
      currentUser.registerEvent(event.ein);
      FirestoreService(uid: currentUser.userId).updateUserPreferences(
          {"registeredEvents": currentUser.registeredEvents});
      FirestoreService(ein: event.ein)
          .updateEventPreferences({"registeredUsers": event.registeredUsers});
    }
  } catch (e) {
    print(e.toString());
  }
  return;
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
