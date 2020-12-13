import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/models/non_profit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String ein;
  String eventName;
  String eventURL;
  EventDate eventDate;
  String location;
  String category;
  String eventContactEmail;
  String imageURI;

  //Has no setters, dependant on database updates until further changes
  Timestamp numericSDate;
  LocationProperties locationProperties;
  String qrCodeURL;
  String organizationName;
  String description;
  int maxCapacity;
  List<dynamic> registeredUsers = [];
  GeoPoint geopoint;

  Events({
    this.ein,
    this.eventName,
    this.eventURL,
    this.eventDate,
    this.location,
    this.category,
    this.eventContactEmail,
    this.imageURI,

    //
    this.numericSDate,
    this.locationProperties,
    this.qrCodeURL,
    this.organizationName,
    this.description,
    this.maxCapacity,
    this.registeredUsers,
    this.geopoint,
  });

  factory Events.fromMap(Map<String, dynamic> json) => Events(
      ein: json["ein"],
      eventName: json["eventName"],
      eventURL: json["eventURL"],
      eventDate: EventDate.fromMap(json["eventDate"]),
      location: json["location"],
      category: json["category"],
      eventContactEmail: json["eventContactEmail"],
      imageURI: json["imageURI"],

      //
      numericSDate: json["numericSDate"],
      locationProperties:
          LocationProperties.fromMap(json["locationProperties"]),
      qrCodeURL: json["qrCodeURL"],
      //orgName: json["organization"],
      organizationName: json["organizationName"],
      description: json["description"],
      maxCapacity: json["maxCapacity"],
      registeredUsers: (json["registeredUsers"] != null)
          ? List<String>.from(json["registeredUsers"].map((x) => x))
          : List<String>(),
      geopoint: json["geopoint"]);

  Map<String, dynamic> toMap() => {
        "ein": ein,
        "eventName": eventName,
        "eventURL": eventURL,
        "eventDate": eventDate.toMap(),
        "location": location,
        "category": category,
        "eventContactEmail": eventContactEmail,
        "imageURI": imageURI,

        //
        "numericSDate": numericSDate,
        "locationProperties": locationProperties.toMap(),
        "qrCodeURL": qrCodeURL,
        "organization": organizationName,
        "description": description,
        "maxCapacity": maxCapacity,
        "registeredUsers": List<dynamic>.from(registeredUsers.map((x) => x)),
        "geopoint": geopoint,
      };

  // Method used to generate string to generate unique QR Code "ticket"
  // Currently, just appends the last 8 digits of a given user's userID
  // to the last 8 digits of the eventID.
  String getSecretString(UserData user) {
    String ss = this.ein.substring(this.ein.length - 8);
    ss += user.userId.substring(user.userId.length - 8);
    return ss;
  }

  // Method used to add user to event's registeredUser list,
  void registerUser(UserData user) {
    this.registeredUsers.add(user.userId);
  }

  void unregisterUser(UserData user) {
    this.registeredUsers.remove(user.userId);
  }
}

class EventDate {
  Timestamp startStamp;
  Timestamp endStanp;
  String startDate;
  String endDate;
  String startTime;
  String endTime;

  EventDate(
      {this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.startStamp,
      this.endStanp});

  factory EventDate.fromMap(Map<String, dynamic> json) => EventDate(
      startDate: json["startDate"],
      endDate: json["endDate"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      startStamp: json["startStamp"],
      endStanp: json["endStamp"]);

  Map<String, dynamic> toMap() => {
        "startDate": startDate,
        "endDate": endDate,
        "startTime": startTime,
        "endTime": endTime,
        "startStamp": startStamp,
        "endStamp": endStanp
      };
}

//Has no setters dependant on database updates until further changes
class LocationProperties {
  String address;
  String city;
  String country;
  String state;
  String zip;

  LocationProperties(
      {this.address, this.city, this.country, this.state, this.zip});

  factory LocationProperties.fromMap(Map<String, dynamic> json) =>
      LocationProperties(
        address: json["address"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
        zip: json["zip"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "city": city,
        "country": country,
        "state": state,
        "zip": zip,
      };
}
