import 'package:flutter/material.dart';
import 'package:chodiapp/constants/AppColors.dart';
import 'package:google_fonts/google_fonts.dart';

class IndividualSignUpPage extends StatefulWidget {

  @override
  _IndividualSignUpPageState createState() => _IndividualSignUpPageState();
}

class _IndividualSignUpPageState extends State<IndividualSignUpPage> {
  List<String> choices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor ,
        title: Text("Sign Up",style: GoogleFonts.ubuntu(fontSize: 25.0, fontWeight: FontWeight.w300,)),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                Text("I have",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 25),),
                SizedBox(height: 20.0,),
                InkWell(
                  onTap: (){},
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.timer,size: 100,),
                          Text("Time")
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                InkWell(
                  onTap: (){},
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.attach_money,size: 100,),
                          Text("Money")
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                InkWell(
                  onTap: (){
                  },
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.accessibility,size: 100,),
                          Text("Resources")
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                FlatButton(
                    onPressed: (){},
                    child: Text("Next",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 28,color: Colors.blue),))

              ],
            )
        ),
      ),
    );
  }
}