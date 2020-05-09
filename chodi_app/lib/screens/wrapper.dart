import 'package:chodiapp/screens/Authenticate/NonAuthenticatedHome.dart';
import 'package:chodiapp/screens/WelcomeWrapper.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/Shared/Loading.dart';
import 'package:chodiapp/models/User.dart';

class Wrapper extends StatelessWidget{
  const Wrapper({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active){
      return userSnapshot.hasData ? WelcomeWrapper() : NonAuthenticatedHomeScreen();
    }
    return Loading();

  }
}
