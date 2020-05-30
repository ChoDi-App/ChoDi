import 'package:chodiapp/auth_widget_builder.dart';
import 'package:chodiapp/screens/Home/search_page/search_page.dart';
import 'package:chodiapp/screens/authenticate/sign_in_page.dart';
import 'package:chodiapp/screens/authenticate/sign_up_page.dart';
import 'package:chodiapp/services/firestore.dart';
import 'package:chodiapp/services/image_picker_service.dart';
import 'services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_widget_builder.dart';
import 'package:chodiapp/screens/wrapper.dart';

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
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        StreamProvider<List<NonProfit>>.value(
          value: FirestoreService().nonProfitData,
          initialData: [NonProfit(), NonProfit(), NonProfit()],
        ),
        StreamProvider<User>.value(value: AuthService().user),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<FirestoreService>(
          create: (_)=> FirestoreService(),
        ),
        //StreamProvider<List<Events>>.value(value: FirestoreService().eventsData),
      ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        //Provider.of<AuthService>(context).signOut();
        return MaterialApp(
          home: Wrapper(userSnapshot: userSnapshot),
          routes: <String, WidgetBuilder>{
            'signInScreen': (BuildContext context) => new SignInPage(),
            'signUpScreen': (BuildContext context) => new SignUpPage(),
            'searchPage': (BuildContext context) => new SearchPage(),
            
          },
        );
      }),
    );
  }
}
