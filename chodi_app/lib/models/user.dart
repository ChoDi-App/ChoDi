// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

class User{
  final String uid;
  final String name;

  User({this.uid,this.name});
}

class UserData {
  String name;
  String userId;
  String cityState;
  String phoneNumber;
  String ageRange;
  List<dynamic> userResources;
  List<dynamic> userInterest;

  UserData({
    this.name,
    this.userId,
    this.cityState,
    this.phoneNumber,
    this.ageRange,
    this.userResources,
    this.userInterest,
  });

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
    name: json["name"],
    userId: json["userId"],
    cityState: json["cityState"],
    phoneNumber: json["phoneNumber"],
    ageRange: json["ageRange"],
    userResources: List<String>.from(json["userResources"].map((x) => x)),
    userInterest: List<String>.from(json["userInterest"].map((x) => x)),
  );

  Map<String, dynamic> toMap(String uid) => {
    "name": name,
    "userId": uid,
    "cityState": cityState,
    "phoneNumber": phoneNumber,
    "ageRange": ageRange,
    "userResources": List<dynamic>.from(userResources.map((x) => x)),
    "userInterest": List<dynamic>.from(userInterest.map((x) => x)),
  };
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