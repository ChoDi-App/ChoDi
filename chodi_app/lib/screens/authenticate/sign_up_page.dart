import 'package:chodiapp/screens/Authenticate/non_profit_sign_up_page.dart';
import 'package:chodiapp/screens/authenticate/multi_step_sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/screens/Authenticate/individual_sign_up_page.dart';
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
          middle: Text(
            "I am a(n)",
            style:
                GoogleFonts.ubuntu(fontWeight: FontWeight.w100, fontSize: 28),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiStepSignUpPage();
                    }));
                  },
                  splashColor: Colors.black,
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage(
                              "images/individual.png",
                            ),
                            size: 100,
                            color: Color.fromRGBO(0, 26, 255, 0.63),
                          ),
                          SizedBox(height: 8.0,),
                          Text(
                            "Individual",
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.black,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NonProfitSignUpPage();
                    }));
                  },
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage(
                              "images/nonprofit.png",
                            ),
                            size: 100,
                            color: Color.fromRGBO(255, 255, 0, 1.0),
                          ),
                          SizedBox(height: 8.0,),
                          Text(
                            "Non-Profit",
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.black,
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.business,
                            size: 100,
                            color: Color.fromRGBO(74, 201, 91, 1.0),
                          ),
                          SizedBox(height: 8.0,),
                          Text(
                            "Corporation",
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
