import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_card_lg.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class v2_ExplorePage extends StatefulWidget {
  String givenQuery;

  v2_ExplorePage(this.givenQuery);

  @override
  _v2_ExplorePage createState() => _v2_ExplorePage();
}

class _v2_ExplorePage extends State<v2_ExplorePage> {
  double _currentSliderValue = 20;
  Position _userPosition;

  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> queryList = filterList(eventsList, widget.givenQuery);
    _determineUserPosition();

    if (widget.givenQuery == "")
      return SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Slider(
                value: _currentSliderValue,
                min: 20,
                max: 100,
                divisions: 10,
                label: _currentSliderValue.round().toString() + " miles",
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
                onChangeEnd: (double value) {
                  log('data: $_currentSliderValue miles');
                  log('user position $_userPosition.latitude $_userPosition.longitude');
                  _showToast(context);
                }
              ),
              SizedBox(height: 30),
              if (eventsList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    "Displaying all ${eventsList.length} events. ",
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )),
              ListView.builder(
                itemCount: eventsList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return v2_EventCard_lg(
                    event: eventsList[index],
                  );
                },
              ),
            ],
          ),
        ),
      );
    else
      return SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 30),
              if (eventsList.length > 0)
                (Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 10.0),
                  //child: Text("Displaying events nearby: $location",
                  child: Text(
                    (queryList.length > 1)
                        ? ("Displaying ${queryList.length} results for '${widget.givenQuery}'.")
                        : ("Displaying ${queryList.length} result for '${widget.givenQuery}'."),
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                )),
              ListView.builder(
                itemCount: queryList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return v2_EventCard_lg(
                    event: queryList[index],
                  );
                },
              ),
            ],
          ),
        ),
      );
  }

  List<Events> filterList(List<Events> someList, String someQuery){
    return someList.where((someEventInList) {
      String fullAddress = _buildAddress(someEventInList);
      bool isEventInRange = false;
      var theQuery = someQuery.toLowerCase();
      var eventTitle = someEventInList.eventName.toLowerCase();
      var eventOrg = someEventInList.orgName.toLowerCase();
      var eventCity = someEventInList.locationProperties.city.toLowerCase();
      var eventState = someEventInList.locationProperties.state.toLowerCase();
      var eventCat = someEventInList.category.toLowerCase();

      // I still haven't figured out the synchronizing, you might get some values too late.
      // Maybe we can map the distances once to the events at the initial building of the widget
      _eventIsInRangeOfUser(fullAddress).then((value) => isEventInRange);
      log('event is in range return $isEventInRange');

      return (eventTitle.contains(theQuery) ||
          eventOrg.contains(theQuery) ||
          eventCity.contains(theQuery) ||
          eventState.contains(theQuery) ||
          eventCat.contains(theQuery)) ;
    }).toList();
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(content: Text(_currentSliderValue.toString() + " miles"))
    );
  }

  Future<bool> _eventIsInRangeOfUser(String _eventAddress) async {
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
    double distanceInMeters =  Geolocator.distanceBetween(uLatitude, uLongitude, eLatitude, eLongitude);
    log('distance in meters = $distanceInMeters m.');

    /*
      Here you would compare the distance in meters to a value that would be set by the user by a Textbox,
      Slider, or something similar. Return a true if the user is within range
     */
    return true;
  }

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

  String _buildAddress(final Events event)
  {
    var eAddress = event.locationProperties.address;
    var eCity = event.locationProperties.city;
    var eState = event.locationProperties.state;
    var eCountry = event.locationProperties.country;

    log("$eAddress $eCity $eState $eCountry".trim());
    return ("$eAddress $eCity $eState $eCountry".trim());
  }

  Future<Position> _determineUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are not enabled');
      return Future.error('Location Services are not enabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      log('Location services are permanently denied');
      return Future.error('Location services are permanently denied, cannot request permission');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        log('Location permissions are denied');
        return Future.error(
            'Location permissions are denied (actual value: $permission).');

      }
    }
    log('enabled permissions');
    _userPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return Future.error("Successfully got position");
  }

}

