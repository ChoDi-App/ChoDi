import 'package:chodiapp/Models/non_profit.dart';
import 'package:chodiapp/Services/firestore.dart';
import 'package:chodiapp/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_select/smart_select.dart';
import 'package:chodiapp/constants/constants.dart';

class NonProfitSignUpPage extends StatefulWidget {

  @override
  _NonProfitSignUpPageState createState() => _NonProfitSignUpPageState();
}

class _NonProfitSignUpPageState extends State<NonProfitSignUpPage> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  NonProfit nonProfit = NonProfit();
  Address address = Address();
  NonProfitContact nonProfitContact = NonProfitContact();
  List<dynamic> categories = [];

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

  Future<NonProfit> _registerNonProfit(BuildContext context, NonProfit nonProfit) async{
    try{
      await FirestoreService().createNonProfit(nonProfit);
      return nonProfit;

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
          middle: Text("Non-Profit Registration",style: GoogleFonts.ubuntu(fontSize: 25.0, fontWeight: FontWeight.w300,)),
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
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the EIN':null,
                          decoration: textInputDecoration.copyWith(hintText: "EIN",),
                          onChanged: (val) {
                            setState(() {nonProfit.ein = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter a Name ':null,
                          decoration: textInputDecoration.copyWith(hintText: "Name",),
                          onChanged: (val) {
                            setState(() {nonProfit.name = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          keyboardType: (TextInputType.number),
                          validator: (val)=> val.isEmpty? 'Enter a year ':null,
                          decoration: textInputDecoration.copyWith(hintText: "Year founded",),
                          onChanged: (val) {
                            setState(() {nonProfit.yearFounded = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the cause ':null,
                          decoration: textInputDecoration.copyWith(hintText: "Cause",),
                          onChanged: (val) {
                            setState(() {nonProfit.cause = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the website':null,
                          decoration: textInputDecoration.copyWith(hintText: "Website",),
                          onChanged: (val) {
                            setState(() {nonProfit.website = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the Mission/Vision':null,
                          decoration: textInputDecoration.copyWith(hintText: "Mission/Vision",),
                          onChanged: (val) {
                            setState(() {nonProfit.missionVision = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          keyboardType: (TextInputType.number),
                          validator: (val)=> val.isEmpty? 'Enter the size of the org':null,
                          decoration: textInputDecoration.copyWith(hintText: "Organization size",),
                          onChanged: (val) {
                            setState(() {nonProfit.size = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Financials website':null,
                          decoration: textInputDecoration.copyWith(hintText: "Financials",),
                          onChanged: (val) {
                            setState(() {nonProfit.financials = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter image URI from firestore':null,
                          decoration: textInputDecoration.copyWith(hintText: "THIS IS TEMP IMAGE UPLOAD HERE",),
                          onChanged: (val) {
                            setState(() {nonProfit.imageURI = val;});
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Categories",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      SmartSelect<dynamic>.multiple(
                          value: categories,
                          title: "Select the categories",
                          options: interestOptions,
                          onChange: (val) => setState(() => categories = val)
                      ),
                      Text("Address",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the street address':null,
                          decoration: textInputDecoration.copyWith(hintText: "Street Address",),
                          onChanged: (val) {
                            setState(() {address.streetAddress = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the city':null,
                          decoration: textInputDecoration.copyWith(hintText: "City",),
                          onChanged: (val) {
                            setState(() {address.city = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the state':null,
                          decoration: textInputDecoration.copyWith(hintText: "State",),
                          onChanged: (val) {
                            setState(() {address.state = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the zip':null,
                          decoration: textInputDecoration.copyWith(hintText: "Zip",),
                          onChanged: (val) {
                            setState(() {address.zip = val;});
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text("Contact data",style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.w100),),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the first name':null,
                          decoration: textInputDecoration.copyWith(hintText: "Contact first name",),
                          onChanged: (val) {
                            setState(() {nonProfitContact.firstName = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the last name':null,
                          decoration: textInputDecoration.copyWith(hintText: "Contact last name",),
                          onChanged: (val) {
                            setState(() {nonProfitContact.lastName = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: _validateEmail,
                          decoration: textInputDecoration.copyWith(hintText: "Contact email",),
                          onChanged: (val) {
                            setState(() {nonProfitContact.email = val;});
                          },
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? 'Enter the phone number':null,
                          decoration: textInputDecoration.copyWith(hintText: "Contact phone number",),
                          onChanged: (val) {
                            setState(() {nonProfitContact.number = val;});
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      FlatButton(
                        child: Text("Register", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100,fontSize: 25, color: Colors.blue),),
                        onPressed: () async{
                          if (_formKey.currentState.validate()){
                            nonProfit.category = categories;
                            nonProfit.address = address;
                            nonProfit.nonProfitContact = nonProfitContact;
                            var result = await  _registerNonProfit(context, nonProfit);
                            if (result != null){
                              showDialog(
                                  context: context, 
                                  child: AlertDialog(
                                    title: Text("Thank You for Registering"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text("Please wait to be approved by admin check email")
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child:  Text("Approve"),
                                        onPressed: () {
                                          Navigator.of(context).popUntil((route) => route.isFirst);
                                        },
                                      )
                                    ],
                                  )
                              );
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