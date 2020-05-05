import 'package:chodiapp/AuthWidgetBuilder.dart';
import 'package:chodiapp/screens/Authenticate/SignInPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chodiapp/Services/Auth.dart';
import 'AuthWidgetBuilder.dart';
import 'package:chodiapp/screens/wrapper.dart';
import 'package:chodiapp/screens/Authenticate/SignUpPage.dart';

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
      ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return MaterialApp(

            home: Wrapper(userSnapshot: userSnapshot),
            routes: <String, WidgetBuilder>{
              'signInScreen' : (BuildContext context) => new SignInPage(),
              'signUpScreen' : (BuildContext context) => new SignUpPage()
        },
          );
        }
      ),
    );
  }
}





