import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_Nav.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_card_lg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:geocoder/geocoder.dart';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class v2_ExplorePage extends StatefulWidget {
  String query;
  Future<Position> userPosition;
  bool filtering;
  List<searchFilterChip> filters;

  v2_ExplorePage({@required this.query, this.userPosition, this.filtering = false, this.filters});

  @override
  _v2_ExplorePage createState() => _v2_ExplorePage();
}

class _v2_ExplorePage extends State<v2_ExplorePage> {
  double distanceRadius = 50;

  @override
  Widget build(BuildContext context) {
    UserData currentUser = Provider.of<UserData>(context);
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> queryList = filterListByQuery(eventsList, widget.query);
    widget.userPosition.then((value) => log("UserPosition: ${value.toString()}"));

    if (widget.query == "")
      // If there's no query...
      return SafeArea(
          child: Container(
        child: FutureBuilder(
            future: getUserPosition(widget.userPosition),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                List<Events> finalList = eventsList;
                if (widget.filtering) {
                  // Filter eventList by distance
                  if (widget.filters[0].selected) {
                    finalList = filterListByRadius(finalList, snapshot.data, distanceRadius);
                  }
                  // Filtering by INTEREST isn't yet implemented
                  if (widget.filters[1].selected) {}
                  // Filtering by COMMUNITY isn't yet implemented
                  if (widget.filters[2].selected) {}
                }

                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: 30),
                    if (finalList.length > 0)
                      (Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                          //child: Text("Displaying events nearby: $location",
                          child: (widget.filtering)
                              ? Text(
                                  "Displaying all ${finalList.length} events within ${distanceRadius.toStringAsFixed(0)} miles. ",
                                  style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                                )
                              : Text(
                                  "Displaying all ${finalList.length} events ",
                                  style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                                )))
                    else
                      (Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                          //child: Text("Displaying events nearby: $location",
                          child: (widget.filtering)
                              ? Center(
                                  child: Text(
                                    "No events within ${distanceRadius.toStringAsFixed(0)} miles. ",
                                    style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "No events ",
                                    style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                                  ),
                                ))),
                    ListView.builder(
                      itemCount: finalList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return v2_EventCard_lg(
                          event: finalList[index],
                          showDistance: true,
                          distanceLabel: getDistanceAsString(
                            userPosition: snapshot.data,
                            event: finalList[index],
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Center(child: Text("Loading events..."));
              }
            }),
      ));
    else
      // If there's a query...
      return SafeArea(
        child: Container(
          child: FutureBuilder(
              future: getUserPosition(widget.userPosition),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  List<Events> finalList = queryList;
                  if (widget.filtering) {
                    // Filter eventList by distance
                    if (widget.filters[0].selected) {
                      finalList = filterListByRadius(finalList, snapshot.data, distanceRadius);
                    }
                  }

                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: 30),
                      if (finalList.length > 0)
                        (Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                          //child: Text("Displaying events nearby: $location",
                          child: Text(
                            (queryList.length > 1)
                                ? ("${finalList.length} results for '${widget.query}'.")
                                : (" ${finalList.length} result for '${widget.query}'."),
                            style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                        ))
                      else
                        Center(
                          child: (Text(
                            "No nearby results for '${widget.query}'.",
                            style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.normal),
                          )),
                        ),
                      ListView.builder(
                        itemCount: finalList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return v2_EventCard_lg(
                            event: finalList[index],
                            showDistance: true,
                            distanceLabel: getDistanceAsString(
                              userPosition: snapshot.data,
                              event: finalList[index],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text("Loading events..."));
                }
              }),
        ),
      );
  }

  Future<Position> getUserPosition(Future<Position> userPosition) async {
    Position p = await userPosition.then((value) => value);
    return p;
  }

  String getDistanceAsString({Position userPosition, Events event, @optionalTypeArgs bool inKilometers = false}) {
    double distance = getDistance(userPosition: userPosition, event: event, inKilometers: inKilometers);
    return (inKilometers) ? "$distance km" : "$distance mi";
  }

  double getDistance({Position userPosition, Events event, @optionalTypeArgs bool inKilometers = false}) {
    double kilometers = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          event.geopoint.latitude,
          event.geopoint.longitude,
        ) /
        1000;
    double miles = kilometers * 0.62137;
    return (inKilometers) ? double.parse(kilometers.toStringAsFixed(2)) : double.parse(miles.toStringAsFixed(2));
  }

  List<Events> filterListByQuery(List<Events> someList, String someQuery) {
    return someList.where((someEventInList) {
      var theQuery = someQuery.toLowerCase();
      var eventTitle = someEventInList.eventName.toLowerCase();
      var eventOrg = someEventInList.organizationName.toLowerCase();
      var eventCity = someEventInList.locationProperties.city.toLowerCase();
      var eventState = someEventInList.locationProperties.state.toLowerCase();
      var eventCat = someEventInList.category.toLowerCase();
      return (eventTitle.contains(theQuery) ||
          eventOrg.contains(theQuery) ||
          eventCity.contains(theQuery) ||
          eventState.contains(theQuery) ||
          eventCat.contains(theQuery));
    }).toList();
  }

  List<Events> filterListByRadius(List<Events> eventsList, Position userPosition, double distanceRadius) {
    return eventsList.where((someEvent) {
      return getDistance(userPosition: userPosition, event: someEvent, inKilometers: false) < distanceRadius;
    }).toList();
  }

  List<Events> filterListByInterest(List<Events> eventsList, UserData currentUser) {
    return eventsList.where((someEvent) {
      for (String interest in currentUser.userInterest) {
        if (someEvent.category == interest) return true;
      }
      return false;
    }).toList();
  }

  // void _showToast(BuildContext context) {
  //   final scaffold = Scaffold.of(context);
  //   scaffold.showSnackBar(
  //       SnackBar(content: Text(_currentSliderValue.toString() + " miles")));
  // }
  //
  Future<bool> _eventIsInRangeOfUser(String _eventAddress, Position _userPosition) async {
    Coordinates eCoordinates = await _getEventCoordinates(_eventAddress);

    // Assume that this is an online or similar event if the Coordinates are null
    if (eCoordinates == null) {
      log('event is in range val is null');
      return true;
    }
    double eLatitude = eCoordinates.latitude;
    double eLongitude = eCoordinates.longitude;
    double uLatitude = _userPosition.latitude;
    double uLongitude = _userPosition.longitude;
    double distanceInMeters = Geolocator.distanceBetween(uLatitude, uLongitude, eLatitude, eLongitude);
    log('distance in meters = $distanceInMeters m.');

    /*
      Here you would compare the distance in meters to a value that would be set by the user by a Textbox,
      Slider, or something similar. Return a true if the user is within range
     */
    return true;
  }

  //
  Future<Coordinates> _getEventCoordinates(final String fullAddress) async {
    List<Address> address;
    log('getEventCoordinates for $fullAddress');

    // If there is no address, return null coordinates
    if (fullAddress.isEmpty) {
      log('was null');
      return null;
    }

    address = await Geocoder.local.findAddressesFromQuery(fullAddress);
    log(address[0].coordinates.toString());

    // If the lookup returns no coordindates, return a null.
    if (address != null) {
      log('successfully returned event coordinates');
      log(address[0].coordinates.toString());
      return address[0].coordinates;
    }
    return null;
  }

  String _buildAddress(final Events event) {
    var eAddress = event.locationProperties.address;
    var eCity = event.locationProperties.city;
    var eState = event.locationProperties.state;
    var eCountry = event.locationProperties.country;

    log("$eAddress $eCity $eState $eCountry".trim());
    return ("$eAddress $eCity $eState $eCountry".trim());
  }

  Future<List<Events>> filterListWithChips(List<Events> eventList, List<searchFilterChip> filters) async {
    List<Events> newList;
    // filters[0] refers to "Near Me" chip
    if (filters[0].selected) {
      Position userPosition = await widget.userPosition;
      newList = eventList.where((someEvent) {
        double distance = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          someEvent.geopoint.latitude,
          someEvent.geopoint.longitude,
        );
        log("distance from event: ${distance} meters");
        return true;
      }).toList();
    }
  }
  //
  // Future<Position> _determineUserPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     log('Location services are not enabled');
  //     return Future.error('Location Services are not enabled');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     log('Location services are permanently denied');
  //     return Future.error(
  //         'Location services are permanently denied, cannot request permission');
  //   }
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse &&
  //         permission != LocationPermission.always) {
  //       log('Location permissions are denied');
  //       return Future.error(
  //           'Location permissions are denied (actual value: $permission).');
  //     }
  //   }
  //   log('enabled permissions');
  //   _userPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low);
  //   return Future.error("Successfully got position");
  // }
}
