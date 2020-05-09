import 'package:chodiapp/models/User.dart';
import 'package:chodiapp/Services/Auth.dart';
import 'package:chodiapp/Services/Database.dart';
import 'package:chodiapp/Shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';
import 'package:chodiapp/constants/TextStyles.dart';
class IndividualSignUpPage extends StatefulWidget {

  @override
  _IndividualSignUpPageState createState() => _IndividualSignUpPageState();
}

class _IndividualSignUpPageState extends State<IndividualSignUpPage> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  List<String> userResources = [];
  List<String> userInterest = [];
  String name = "";
  String email= "";
  String password = "";
  String cityState = "";
  String phoneNumber = "";
  String ageRange= "Age-Age";


  bool agreedToTerms = false;

  List<String> listOfAgeRange= ["Under 18","18-24","25-34", "35-44","45-54","55-64", "65 or older"];

  var resourcesOptions = [
    SmartSelectOption<String>(value: "time", title: 'Time'),
    SmartSelectOption<String>(value: "money", title: 'Money'),
    SmartSelectOption<String>(value: "resources", title: 'Resources'),
  ];
  var interestOptions = [
    SmartSelectOption<String>(value: "human rights", title: 'Human Rights'),
    SmartSelectOption<String>(value: "policy", title: 'Policy'),
    SmartSelectOption<String>(value: "environment", title: 'Environment'),
    SmartSelectOption<String>(value: "animals", title: "Animals"),
  ];

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
  Future<User> _registerIndividualUser(BuildContext context, String email, String password,String name, String cityState, String phoneNumber, String ageRange,List<String> userResources,List<String> userInterest ) async{
    try{
      final auth = Provider.of<AuthService>(context,listen: false);

      User user = await auth.registerWithEmailAndPassword(email, password);
      await DatabaseService(uid: user.uid).createNewIndividualUser(name,cityState,phoneNumber,ageRange,userResources,userInterest);
      return user;


    }catch(e){
      print(e.toString());
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      child: loading? Loading(): CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(
            bottom: BorderSide.none
          ),
          middle: Text("Sign Up",style: GoogleFonts.ubuntu(fontSize: 25.0, fontWeight: FontWeight.w300,)),
        ),
        child: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Donations",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      SmartSelect<String>.multiple(
                          value: userResources,
                          title: "I have: ",
                          options: resourcesOptions ,
                          onChange: (val) => setState(() => userResources = val)
                      ),
                      Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      SizedBox(height: 20,),
                      Text("Interests",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      SmartSelect<String>.multiple(
                          value: userInterest,
                          title: "I am interested in: ",
                          options: interestOptions ,
                          onChange: (val) => setState(() => userInterest = val)
                      ),
                      Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      SizedBox(height: 20,),
                      Text("Full Name",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter a Name ':null,
                          decoration: textInputDecoration.copyWith(hintText: "Name",),
                          onChanged: (val) {
                            setState(() {name = val;});
                          },
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text("Email Address",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
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
                      SizedBox(height: 30,),
                      Text("Password",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
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
                      ),
                      SizedBox(height: 30,),
                      Text("Current City/ State",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter a City and State ':null,
                          decoration: textInputDecoration.copyWith(hintText: "Los Angeles, CA"),
                          onChanged: (val){
                            setState(() {cityState = val;});
                          },
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text("Mobile Number",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter a Number ':null,
                          decoration: textInputDecoration.copyWith(hintText: "+387 623 1234"),
                          onChanged: (val){
                            setState(() {phoneNumber = val;});
                          },
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text("Please Select Age Range",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      SizedBox(height: 20,),
                      Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      FlatButton(
                        child: Text("$ageRange",style: GoogleFonts.ubuntu(fontSize: 18, color: Colors.blue),),
                        onPressed: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder){
                                return Material(
                                  child: Container(
                                    height:  MediaQuery.of(context).size.height / 3,
                                    child: CupertinoPicker(
                                      magnification: 1.2,
                                      backgroundColor: Colors.white,
                                      children: <Widget>[
                                        Text("Under 18"),
                                        Text("18-24"),
                                        Text("25-34"),
                                        Text("35-44"),
                                        Text("45-54"),
                                        Text("55-64"),
                                        Text("65 or order"),
                                      ],
                                      itemExtent: 50,
                                      looping: false,
                                      onSelectedItemChanged: (int index){
                                        setState(() {
                                          ageRange = listOfAgeRange[index];
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                      ),
                      Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.only(right: 50),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value){
                                setState(() {
                                  agreedToTerms = value;
                                });
                              },
                            ),
                            Text("I accept Terms of Use and Privacy Policy",style: GoogleFonts.ubuntu(fontSize: 10,fontWeight: FontWeight.w100,color: Colors.grey),)
                          ],
                        ),
                      ),
                      FlatButton(
                        child: Text("Apply", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 25, color: Colors.blue),),
                        onPressed: () async{
                          if (_formKey.currentState.validate()){
                            if(userInterest.isNotEmpty && userResources.isNotEmpty){
                              if (ageRange != "Age-Age"){
                                if (agreedToTerms){
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = _registerIndividualUser(context, email, password, name, cityState, phoneNumber, ageRange, userResources, userInterest);
                                  if (result == null){
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }
                                if(agreedToTerms == false){
                                  print("Please Agree to Terms");
                                }
                              }
                              if (ageRange == "Age-Age"){
                                print("Please Select an Age Range");

                              }
                            }
                            if (userInterest.isEmpty || userResources.isEmpty){
                              print("Please fill select and interest and or donations");

                            }
                          }
                        },
                      )










                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}