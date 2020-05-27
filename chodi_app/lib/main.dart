import 'package:chodiapp/auth_widget_builder.dart';
import 'package:chodiapp/screens/Authenticate/sign_in_page.dart';
import 'package:chodiapp/screens/Home/search_page/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chodiapp/Services/auth.dart';
import 'Services/firestore.dart';
import 'auth_widget_builder.dart';
import 'package:chodiapp/screens/wrapper.dart';
import 'package:chodiapp/screens/Authenticate/sign_up_page.dart';

import 'models/non_profit.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_)=> AuthService(),
        ),
        StreamProvider<List<NonProfit>>.value(
          value: FirestoreService().nonProfitData,
          initialData: [NonProfit(),NonProfit(),NonProfit()],
        ),
        StreamProvider<User>.value(value: AuthService().user),
      ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return MaterialApp(

            home: Wrapper(userSnapshot: userSnapshot),
            routes: <String, WidgetBuilder>{
              'signInScreen' : (BuildContext context) => new SignInPage(),
              'signUpScreen' : (BuildContext context) => new SignUpPage(),
              'searchPage' : (BuildContext context) => new SearchPage(),
        },
          );
        }
      ),
    );
  }
}





