import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/models/non_profit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_path.dart';

class FirestoreService {
  FirestoreService({this.uid, this.ein});

  final String uid;
  final String ein;
  final userCollection = Firestore.instance.collection("users");
  final nonProfitCollection = Firestore.instance.collection("nonProfits");
  final eventsCollection = Firestore.instance.collection("events");

  Future createIndividualUser(UserData userData) async {
    return await userCollection.document(uid).setData(userData.toMap(uid));
  }

  Future updateIndividualUser(UserData userData) async {
    return await userCollection.document(uid).updateData(userData.toMap(uid));
  }

  Future createNonProfit(NonProfit nonProfit) async {
    return await nonProfitCollection
        .document(nonProfit.ein)
        .setData(nonProfit.toMap());
  }

  Future updateNonProfit(NonProfit nonProfit) async {
    return await nonProfitCollection
        .document(nonProfit.ein)
        .updateData(nonProfit.toMap());
  }

  // updates user information if they change it.
  Future updateUserPreferences(Map<String, dynamic> map) async {
    return await userCollection.document(uid).updateData(map);
  }

  Future updateEventPreferences(Map<String, dynamic> map) async {
    return await eventsCollection.document(ein).updateData(map);
  }

  // Sets the avatar download url
  Future<void> setAvatarReference(String downloadUrl) async {
    return await userCollection
        .document(uid)
        .updateData({"avatarDownloadUrl": downloadUrl});
  }

  List<NonProfit> _nonProfitListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return NonProfit.fromMap(doc.data);
    }).toList();
  }

  List<Events> _eventsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Events.fromMap(doc.data);
    }).toList();
  }

  Stream<UserData> get userData {
    return userCollection
        .document(uid)
        .snapshots()
        .map((snap) => UserData.fromMap(snap.data));
  }

  Stream<List<NonProfit>> get nonProfitData {
    return nonProfitCollection.snapshots().map(_nonProfitListFromSnapshot);
  }

  Stream<List<Events>> get eventsData {
    return eventsCollection.snapshots().map(_eventsFromSnapshot);
  }
}
