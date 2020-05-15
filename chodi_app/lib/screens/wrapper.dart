import 'package:chodiapp/screens/Authenticate/non_authenticated_home.dart';
import 'package:chodiapp/screens/welcome_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/Shared/loading.dart';
import 'package:chodiapp/models/user.dart';

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
