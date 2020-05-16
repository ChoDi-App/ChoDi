// To parse this JSON data, do
//
//     final nonProfit = nonProfitFromJson(jsonString);

import 'dart:convert';

NonProfit nonProfitFromJson(String str) => NonProfit.fromMap(json.decode(str));

String nonProfitToJson(NonProfit data) => json.encode(data.toMap());

class NonProfit {
  Address address;
  String cause;
  NonProfitContact nonProfitContact;
  List<dynamic> category;
  String ein;
  String financials;
  String yearFounded;
  String missionVision;
  String name;
  String size;
  String website;
  String imageURI;

  NonProfit({
    this.address,
    this.cause,
    this.nonProfitContact,
    this.category,
    this.ein,
    this.financials,
    this.yearFounded,
    this.missionVision,
    this.name = "",
    this.size,
    this.website,
    this.imageURI,
  });

  factory NonProfit.fromMap(Map<String, dynamic> json) => NonProfit(
    address: Address.fromMap(json["address"]),
    cause: json["cause"],
    nonProfitContact: NonProfitContact.fromMap(json["nonProfitContact"]),
    category: List<String>.from(json["category"].map((x) => x)),
    ein: json["ein"],
    financials: json["financials"],
    yearFounded: json["yearFounded"],
    missionVision: json["missionVision"],
    name: json["name"],
    size: json["size"],
    website: json["website"],
    imageURI: json['imageURI'],
  );

  Map<String, dynamic> toMap() => {
    "address": address.toMap(),
    "cause": cause,
    "nonProfitContact": nonProfitContact.toMap(),
    "category": List<dynamic>.from(category.map((x) => x)),
    "ein": ein,
    "financials": financials,
    "yearFounded": yearFounded,
    "missionVision": missionVision,
    "name": name,
    "size": size,
    "website": website,
    "imageURI": imageURI,
  };
}

class Address {
  String streetAddress;
  String city;
  String state;
  String zip;

  Address({
    this.streetAddress,
    this.city,
    this.state,
    this.zip,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    streetAddress: json["streetAddress"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
  );

  Map<String, dynamic> toMap() => {
    "streetAddress": streetAddress,
    "city": city,
    "state": state,
    "zip": zip,
  };
}

class NonProfitContact {
  String firstName;
  String lastName;
  String email;
  String number;

  NonProfitContact({
    this.firstName,
    this.lastName,
    this.email,
    this.number,
  });

  factory NonProfitContact.fromMap(Map<String, dynamic> json) => NonProfitContact(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    number: json["number"],
  );

  Map<String, dynamic> toMap() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "number": number,
  };
}

// JSON Format example

//{
//    "address": "Rack",
//    "cause": "man",
//    "address": {
//        "streetAddress": "126",
//        "city": "San Jone",
//        "state": "CA",
//        "zip": "394221"
//    },
//    "nonProfitContact": {
//        "name": "126",
//        "email": "San Jone",
//        "number": "CA"
//    },
//    "category": [
//        "Jackon", "asdasdas"
//        ],
//    "ein": "ein",
//    "financials": "asdasdasd",
//    "yearFounded": 123123,
//    "missionVision": "asdasdonVision",
//    "name": "nameaasd",
//    "size": 123123,
//    "website": "website"
//}