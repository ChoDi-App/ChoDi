import 'package:chodiapp/Services/Database.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/Services/Auth.dart';
import 'package:chodiapp/Shared/Loading.dart';
import 'package:chodiapp/constants/TextStyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:chodiapp/Models/User.dart';
import 'package:smart_select/smart_select.dart';

class FinishSignUpGooglePage extends StatefulWidget {
  @override
  _FinishSignUpGooglePageState createState() => _FinishSignUpGooglePageState();
}

class _FinishSignUpGooglePageState extends State<FinishSignUpGooglePage> {

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
    return Container();
  }
}
