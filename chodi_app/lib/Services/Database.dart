import 'package:chodiapp/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{
  DatabaseService({this.uid});
  final String uid;


  final userCollection = Firestore.instance.collection("users");

  Future createNewIndividualUser( String name, String cityState, String phoneNumber , String ageRange, List<String> userResources, List<String> userInterest) async{
    return await userCollection.document(uid).setData({
      "userId": uid,
      "name" : name,
      "cityState" : cityState,
      "phoneNumber" : phoneNumber,
      "ageRange" : ageRange,
      "userResources" : userResources,
      "userInterest" : userInterest,

    });

  }
  Future updateNewUser( String name, String cityState, String phoneNumber , String ageRange, List<String> userResources, List<String> userInterest) async{
    return await userCollection.document(uid).updateData({
      "userId": uid,
      "name" : name,
      "cityState" : cityState,
      "phoneNumber" : phoneNumber,
      "ageRange" : ageRange,
      "userResources" : userResources,
      "userInterest" : userInterest,
    });
  }


  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
        .map((snap) => UserData.fromMap(snap.data));
  }



}