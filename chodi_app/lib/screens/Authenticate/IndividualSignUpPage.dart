import 'package:flutter/material.dart';
import 'package:chodiapp/constants/AppColors.dart';
import 'package:google_fonts/google_fonts.dart';

class IndividualSignUpPage extends StatefulWidget {
  List<String> choices;
  IndividualSignUpPage({this.choices});

  @override
  _IndividualSignUpPageState createState() => _IndividualSignUpPageState();
}

class _IndividualSignUpPageState extends State<IndividualSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor ,
        title: Text("Sign Up",style: GoogleFonts.ubuntu(fontSize: 25.0, fontWeight: FontWeight.w300,)),
      ),
      body: Center(
          child: Text("Individual Sign up")
      ),
    );
  }
}