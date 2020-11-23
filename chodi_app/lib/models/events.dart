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
  String orgName;

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
    this.orgName,
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
        orgName: "Organization_Name",
      );

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
        "orgName": orgName,
      };
}

class EventDate {
  String startDate;
  String endDate;
  String startTime;
  String endTime;

  EventDate({this.startDate, this.endDate, this.startTime, this.endTime});

  factory EventDate.fromMap(Map<String, dynamic> json) => EventDate(
        startDate: json["startDate"],
        endDate: json["endDate"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toMap() => {
        "startDate": startDate,
        "endDate": endDate,
        "startTime": startTime,
        "endTime": endTime
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
