import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/Shared/loading.dart';
import 'package:chodiapp/screens/Authenticate/finish_sign_up_google_page.dart';
import 'package:chodiapp/screens/Home/authenticated_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chodiapp/screens/home/tab_pages/events_tab/events_AgendaCalendar.dart';

class WelcomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);

    if (userData != null) {
      if (userData.name == "New User") {
        return FinishSignUpGooglePage();
      } else {
        return AuthenticatedHomeScreen();
        //return v2_AgendaCalendar();
      }
    }
    if (userData == null) {
      return Loading();
    }
  }
}
