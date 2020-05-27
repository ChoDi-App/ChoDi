
class Events{
  String ein;
  List<dynamic> events;

  Events({
    this.ein,
    this.events
  });
  factory Events.fromMap(Map<String, dynamic> json) => Events(
    ein: json["ein"],
    events: List<dynamic>.from(json["events"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "ein" : ein,
    "events" : List<dynamic>.from(events.map((x) => x)),
  };

}


class Event{
  String eventName;
  String eventURL;
  EventDate eventDate;
  String location;
  String category;
  String eventContactEmail;

  Event({
    this.eventName,
    this.eventURL,
    this.eventDate,
    this.location,
    this.category,
    this.eventContactEmail
});
  factory Event.fromMap(Map<String, dynamic> json) => Event(
    eventName: json["eventName"],
    eventURL: json["eventURL"],
    eventDate: EventDate.fromMap(json["eventDate"]),
    location: json["location"],
    category: json["category"],
    eventContactEmail: json["eventContactEmail"]

  );

  Map<String, dynamic> toMap() => {
    "eventName" : eventName,
    "eventURL" : eventURL,
    "eventDate" : eventDate.toMap(),
    "location" : location,
    "category" : category,
    "eventContactEmail" : eventContactEmail

  };


}

class EventDate{
  String date;
  String startTime;
  String endTime;

  EventDate({
    this.date,
    this.startTime,
    this.endTime
});
  factory EventDate.fromMap(Map<String, dynamic> json) => EventDate(
    date: json["date"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toMap() => {
    "date": date,
    "startTime" : startTime,
    "endTime" : endTime
  };

}