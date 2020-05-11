import 'package:chodiapp/Models/user.dart';
import 'package:chodiapp/Models/non_profit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirestoreService({this.uid});
  final String uid;
  final userCollection = Firestore.instance.collection("users");
  final nonProfitCollection = Firestore.instance.collection("nonProfits");

  Future createIndividualUser(UserData userData) async{
    return await userCollection.document(uid).setData(userData.toMap(uid));
  }

  Future updateIndividualUser(UserData userData) async{
    return await userCollection.document(uid).updateData(userData.toMap(uid));
  }

  Future createNonProfit(NonProfit nonProfit) async{
    return await nonProfitCollection.document(nonProfit.ein).setData(nonProfit.toMap());
  }

  Future updateNonProfit(NonProfit nonProfit) async{
    return await nonProfitCollection.document(nonProfit.ein).updateData(nonProfit.toMap());
  }

  List<NonProfit> _nonProfitListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return NonProfit.fromMap(doc.data);
      }
    ).toList();
  }

  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
        .map((snap) => UserData.fromMap(snap.data));
  }

  Stream<List<NonProfit>> get nonProfitData{
    return nonProfitCollection.snapshots()
        .map(_nonProfitListFromSnapshot);
  }

}