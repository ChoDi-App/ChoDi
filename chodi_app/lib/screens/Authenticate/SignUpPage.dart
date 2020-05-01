import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/constants/AppColors.dart';
import 'package:chodiapp/screens/Authenticate/IndividualSignUpPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: FlatButton(
                onPressed: (){
                  Navigator.pop(context);

                },
                child: Text("Sign In",
                  style: GoogleFonts.ubuntu(fontSize: 15,fontWeight: FontWeight.w100,color: Colors.black),
                )
            ),
          )
        ],
        title: Text("Sign Up",style: GoogleFonts.ubuntu(fontSize: 25.0, fontWeight: FontWeight.w300,)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height:30.0),
              Text("I am a(n)",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 28),),

              SizedBox(height: 30.0,),
              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return IndividualSignUpPage();
                  }));
                },
                splashColor: Colors.blue,
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.people,size: 100,),
                        Text("Individual")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Card(
                elevation: 8.0,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.money_off,size: 100,),
                      Text("Non-Profit")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: (){
                  print("Tapped");


                },
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.business,size: 100,),
                        Text("Corporation")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}






