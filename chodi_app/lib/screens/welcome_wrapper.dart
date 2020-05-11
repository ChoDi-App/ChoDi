import 'package:chodiapp/Models/user.dart';
import 'package:chodiapp/Shared/loading.dart';
import 'package:chodiapp/screens/Authenticate/finish_sign_up_google_page.dart';
import 'package:chodiapp/screens/Home/authenticated_home.dart';
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
