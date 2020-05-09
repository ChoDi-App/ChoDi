import 'package:chodiapp/models/User.dart';
import 'package:chodiapp/Shared/Loading.dart';
import 'package:chodiapp/screens/Authenticate/FinishSignUpGooglePage.dart';
import 'package:chodiapp/screens/Home/AuthenticatedHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeWrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);

    if (userData != null){
      if (userData.name == "New User"){
        return FinishSignUpGooglePage();
      }
      else{
        return AuthenticatedHomeScreen();
      }
    }
    if (userData == null){
      return Loading();
    }
  }
}
