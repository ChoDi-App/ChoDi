class User{
  final String uid;
  final String name;

  User({this.uid,this.name});
}

class UserData{
  final String userId;
  final String name;
  final String cityState;
  final String phoneNumber;
  final String ageRange;
  final List<dynamic> userResources;
  final List<dynamic> userInterest;
  UserData({this. userId,this.name,this.cityState,this.phoneNumber,this.ageRange,this.userResources,this.userInterest});

  factory UserData.fromMap(Map data){
    data = data ?? {};
    return UserData(
      userId : data["userId"] ?? "",
      name: data["name"] ?? "" ,
      cityState: data["cityState"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      ageRange :data["ageRange"] ?? "",
      userResources: data["userResources"] ?? [],
      userInterest: data["userInterest"] ?? [],
    );
  }
}