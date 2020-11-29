// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

class User {
  final String uid;
  final String name;

  User({this.uid, this.name});
}

class UserData {
  String name;
  String userId;
  String zipCode;
  String phoneNumber;
  String ageRange;
  List<dynamic> userResources = [];
  List<dynamic> userInterest = [];
  List<dynamic> registeredEvents = [];
  List<dynamic> savedEvents = [];
  String avatarDownloadUrl;

  UserData({
    this.name,
    this.userId,
    this.zipCode,
    this.phoneNumber,
    this.ageRange,
    this.userResources,
    this.userInterest,
    this.registeredEvents,
    this.savedEvents,
    this.avatarDownloadUrl,
  });

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        name: json["name"],
        userId: json["userId"],
        zipCode: json["zipCode"],
        phoneNumber: json["phoneNumber"],
        ageRange: json["ageRange"],
        userResources: List<String>.from(json["userResources"].map((x) => x)),
        userInterest: List<String>.from(json["userInterest"].map((x) => x)),
        registeredEvents: json["registeredEvents"] != null
            ? List<String>.from(json["registeredEvents"].map((x) => x))
            : List<String>(),
        savedEvents: json["savedEvents"] != null
            ? List<String>.from(json["savedEvents"].map((x) => x))
            : List<String>(),
        avatarDownloadUrl: json['avatarDownloadUrl'],
      );

  Map<String, dynamic> toMap(String uid) => {
        "name": name,
        "userId": uid,
        "zipCode": zipCode,
        "phoneNumber": phoneNumber,
        "ageRange": ageRange,
        "userResources": List<dynamic>.from(userResources.map((x) => x)),
        "userInterest": List<dynamic>.from(userInterest.map((x) => x)),
        "registeredEvents": List<dynamic>.from(registeredEvents.map((x) => x)),
        "savedEvents": List<dynamic>.from(savedEvents.map((x) => x)),
        "avatarDownloadUrl": avatarDownloadUrl
      };

  void registerEvent(String eventID) {
    this.registeredEvents.add(eventID);
  }

  void unregisterEvent(String eventID) {
    this.registeredEvents.remove(eventID);
  }
}

//
//class UserData{
//  String userId;
//  String name;
//  final String cityState;
//  final String phoneNumber;
//  final String ageRange;
//  final List<dynamic> userResources;
//  final List<dynamic> userInterest;
//  UserData({this. userId,this.name,this.cityState,this.phoneNumber,this.ageRange,this.userResources,this.userInterest});
//
//  factory UserData.fromMap(Map data){
//    data = data ?? {};
//    return UserData(
//      userId : data["userId"] ?? "",
//      name: data["name"] ?? "" ,
//      cityState: data["cityState"] ?? "",
//      phoneNumber: data["phoneNumber"] ?? "",
//      ageRange :data["ageRange"] ?? "",
//      userResources: data["userResources"] ?? [],
//      userInterest: data["userInterest"] ?? [],
//    );
//  }
//}
