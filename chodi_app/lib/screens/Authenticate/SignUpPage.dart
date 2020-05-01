
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/screens/Authenticate/IndividualSignUpPage.dart';
import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(bottom: BorderSide.none),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 10.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Text("I am a(n)",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 28),),
              Material(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return IndividualSignUpPage();
                    }));
                  },
                  splashColor: Colors.black,
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
              ),
              Material(
                child: InkWell(
                  splashColor: Colors.black,
                  onTap: (){print("clicked");},
                  child: Card(
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
                ),
              ),
              Material(
                child: InkWell(
                  onTap: (){},
                  splashColor: Colors.black,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}






