



class Events{
  String ein;
  String eventName;
  String eventURL;
  EventDate eventDate;
  String location;
  String category;
  String eventContactEmail;
  String imageURI;

  Events({
    this.ein,
    this.eventName,
    this.eventURL,
    this.eventDate,
    this.location,
    this.category,
    this.eventContactEmail,
    this.imageURI
});
  factory Events.fromMap(Map<String, dynamic> json) => Events(
    ein: json["ein"],
    eventName: json["eventName"],
    eventURL: json["eventURL"],
    eventDate: EventDate.fromMap(json["eventDate"]),
    location: json["location"],
    category: json["category"],
    eventContactEmail: json["eventContactEmail"],
    imageURI: json["imageURI"]

  );

  Map<String, dynamic> toMap() => {
    "ein" : ein,
    "eventName" : eventName,
    "eventURL" : eventURL,
    "eventDate" : eventDate.toMap(),
    "location" : location,
    "category" : category,
    "eventContactEmail" : eventContactEmail,
    "imageURI" : imageURI

  };


}

class EventDate{
  String startDate;
  String endDate;
  String startTime;
  String endTime;

  EventDate({
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime
});
  factory EventDate.fromMap(Map<String, dynamic> json) => EventDate(
    startDate: json["startDate"],
    endDate: json["endDate"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toMap() => {
    "startDate": startDate,
    "endDate" : endDate,
    "startTime" : startTime,
    "endTime" : endTime
  };

}