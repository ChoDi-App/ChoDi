import 'package:firebase_auth/firebase_auth.dart';
import 'package:chodiapp/Models/User.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return (user != null ? User(uid: user.uid) : null);
  }


  // auth changed user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future<User> signInAnon() async {
    final AuthResult result = await _auth.signInAnonymously();
    return _userFromFirebaseUser(result.user);

  }


  //register email and pass
  Future<User> registerWithEmailAndPassword(String email, String password) async{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }


  //signIn with email pass
  Future<User> signInWithEmailAndPassword(String email, String password) async{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }


  // signout
  Future<void> signOut() async {
    return await _auth.signOut();

  }

}