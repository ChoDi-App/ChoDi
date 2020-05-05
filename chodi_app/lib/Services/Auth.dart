import 'package:chodiapp/Services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chodiapp/Models/User.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<User> get user;
  Future<User> signInAnon();
  Future<User> registerWithEmailAndPassword(String email, String password);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User> signInWithGoogle();

}

class AuthService implements AuthBase{

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
  Future <User> signInWithGoogle() async{
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();

    if(googleAccount != null){
      final googleAuth = await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        final authResult = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        if (authResult.additionalUserInfo.isNewUser){
          await DatabaseService(uid: authResult.user.uid).createNewIndividualUser("New User", "", "", "", [], []);
          return _userFromFirebaseUser(authResult.user);
        }
        return _userFromFirebaseUser(authResult.user);
      } else{
        throw PlatformException(
          code: "ERROR_MISSING_GOOGLE_AUTH_TOKEN",
          message: "missing google auth token"
        );
      }
    }else{
      throw PlatformException(
        code: "ERROR_ABORTED_BY_USER",
        message: "sign in aborted ny user",
      );
    }


  }


  // signout
  Future<void> signOut() async {
    return await _auth.signOut();

  }

}