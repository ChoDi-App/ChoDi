import 'package:flutter/material.dart';
import 'package:chodiapp/Services/Auth.dart';
import 'package:chodiapp/Shared/Loading.dart';
import 'package:chodiapp/constants/TextStyles.dart';
import 'package:google_fonts/google_fonts.dart';
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();


  String email = "";
  String password = "";

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  String _validatePassword(String value){
    Pattern pattern = r'^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value))
      return "Enter Stronger Password";
    else
      return null;
  }


  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Sign In",
          style: GoogleFonts.ubuntu(fontSize: 25.0, fontWeight: FontWeight.w300,)),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0,),
                  Text("To use these features please sign in or sign up. Thanks.",
                  style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 17.0,color: Colors.grey)),
                  SizedBox(height: 50.0,),
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Email Address", style: GoogleFonts.ubuntu(fontSize: 15),),
                      ),
                      SizedBox(height: 20.0,),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: _validateEmail,
                          decoration: textInputDecoration.copyWith(hintText: "example@gmail.com",),
                          onChanged: (val) {
                            setState(() {email = val;});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Password", style: GoogleFonts.ubuntu(fontSize: 15),),
                      ),
                      SizedBox(height: 20.0,),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: _validatePassword,
                          decoration: textInputDecoration.copyWith(hintText: ".............."),
                          obscureText: true,
                          onChanged: (val){
                            setState(() {password = val;});
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50,),
                  FlatButton(
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() {loading = true;});
                        dynamic result = await _auth.signInAnon();
                        if (result == null){
                          print("couldn't sign in ");
                          setState(() {loading = false;});
                        }
                      }

                    },
                    child: Text("Log In",
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,color: Colors.black,fontSize: 22 ),),
                  ),
                  SizedBox(height: 30,),
                  Text("OR",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,color: Colors.grey,fontSize: 15),),
                  SizedBox(height: 30,),
                  RaisedButton(
                    color: Color.fromRGBO(78, 174, 255,10),
                    padding: EdgeInsets.all(8.0),
                    onPressed: (){},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                          child:Image.asset('images/google-icon.png',height: 20,width: 20,),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Continue with Google",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize:22,color: Colors.white ),),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Don't Have an Account?",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 15),),
                      FlatButton(
                        child: Text("Sign Up",style: GoogleFonts.ubuntu(fontWeight: FontWeight.w400,fontSize: 17,color: Colors.blue),),
                        onPressed: (){
                          Navigator.of(context).pushNamed('signUpScreen');
                        },
                      )
                    ],
                  )








                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}