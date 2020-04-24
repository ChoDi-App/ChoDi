import 'package:chodiapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'constants/AppColors.dart';
// testing git

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(


        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen()
    );
  }
}





