import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/services/auth.dart';
import 'package:chodiapp/services/firestore.dart';
import 'package:chodiapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chodiapp/screens/authenticate/mutli_page_form_widget.dart';
import 'package:provider/provider.dart';

import 'multi_step_sign_up_page.dart';

class FinishSignUpGooglePage extends StatefulWidget {
  @override
  _FinishSignUpGooglePageState createState() => _FinishSignUpGooglePageState();
}

class _FinishSignUpGooglePageState extends State<FinishSignUpGooglePage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  UserData userData = UserData(userResources: [], userInterest: []);
  String email = "";
  String password = "";
  List<dynamic> userResources = [];
  List<dynamic> userInterest = [];
  int currentPage = 0;

  bool agreedToTerms = false;

  List<String> listOfAgeRange = [
    "Under 18",
    "18-24",
    "25-34",
    "35-44",
    "45-54",
    "55-64",
    "65 or older"
  ];

  List<String> resourcesOptions = [
    "time",
    "money",
    "resources",
  ];
  List<String> interestsOptions = [
    "human-rights",
    "policy",
    "environment",
    "animals"
  ];
  Map<String, Color> donationsColorsMap = {
    "time": Color.fromRGBO(0, 26, 255, .63),
    "money": Color.fromRGBO(255, 255, 0, 1.0),
    "resources": Color.fromRGBO(74, 201, 19, 1.0),
  };
  Map<String, Color> interestsColorsMap = {
    "human-rights": Color.fromRGBO(0, 26, 255, .63),
    "policy": Color.fromRGBO(255, 255, 0, 1.0),
    "environment": Color.fromRGBO(74, 201, 19, 1.0),
    "animals": Color.fromRGBO(242, 122, 84, 1.0)
  };

  bool _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value);
  }

  bool _validatePassword(String value) {
    Pattern pattern =
        r'^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future<User> _registerIndividualUser(BuildContext context, String email,
      String password, UserData userData) async {
    try {
      User user = Provider.of<User>(context, listen: false);
      await FirestoreService(uid: user.uid).updateIndividualUser(userData);
      return user;
    } catch (e) {
      _showDialog("The email address is already in use by another account.");
      print(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: loading
          ? Loading()
          : CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(bottom: BorderSide.none),
          middle: Text(
            "Sign Up",
            style: GoogleFonts.ubuntu(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          leading: Material(
            child: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: MultiPageForm(
                  totalPage: 4,
                  nextButtonStyle: FlatButton(
                    child: Text(
                      "Next",
                      style: GoogleFonts.ubuntu(
                          fontSize: 17, color: Colors.blue),
                    ),
                  ),
                  previousButtonStyle: FlatButton(
                    child: Text(
                      "Previous",
                      style: GoogleFonts.ubuntu(
                          fontSize: 17, color: Colors.blue),
                    ),
                  ),
                  submitButtonStyle: FlatButton(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.ubuntu(
                          fontSize: 17, color: Colors.blue),
                    ),
                  ),
                  onNextPressed: () {
                    return validation();
                  },
                  pageList: [page1(), page2(), page3(), page4()],
                  onFormSubmitted: () async {
                    if (userData.userInterest.isNotEmpty) {
                      _registerIndividualUser(
                          context, email, password, userData);
                    } else {
                      _showDialog("Please make sure you select what you can provide and your interests, must select at a least one option of each to continue.");
                    }
                  },
                ),
              ),
            )),
      ),
    );
  }

  Widget page1() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "New Account",
            style:
            GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w100),
          ),
          SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextFormField(
              validator: (val) => val.isEmpty ? 'Enter a Name ' : null,
              decoration: InputDecoration(labelText: "First and Last Name"),
              onChanged: (val) {
                setState(() {
                  userData.name = val;
                });
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget page2() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Personal Information",
              style:
              GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Enter a Number ' : null,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.numberWithOptions(),
              onChanged: (val) {
                setState(() {
                  userData.phoneNumber = val;
                });
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            DropdownButton(
              hint: Text("Please Choose Age Range"),
              value: userData.ageRange,
              onChanged: (newValue) {
                setState(() {
                  userData.ageRange = newValue;
                });
              },
              items: listOfAgeRange.map((ageRange) {
                return DropdownMenuItem(
                  child: new Text(ageRange),
                  value: ageRange,
                );
              }).toList(),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Enter Zip Code' : null,
              decoration: InputDecoration(labelText: "Zip Code"),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  userData.zipCode = val;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(right: 50),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreedToTerms = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "I accept Terms of Use and Privacy Policy",
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.ubuntu(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page3() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Text(
            "I have (select all that apply)",
            style:
            GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w100),
          ),
          SizedBox(
            height: 30.0,
          ),
          GridView.count(
            physics: ScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(right: 30, left: 30),
            mainAxisSpacing: 8,
            children: resourcesOptions.map((imageName) {
              return GestureDetector(
                onTap: () {
                  if (userData.userResources.contains(imageName)) {
                    setState(() {
                      userData.userResources.remove(imageName);
                    });
                  } else if (!userData.userResources.contains(imageName)) {
                    setState(() {
                      userData.userResources.add(imageName);
                    });
                  }
                  print(userData.userResources);
                },
                child: GridViewItem(
                    imageName,
                    userData.userResources.contains(imageName),
                    donationsColorsMap[imageName]),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget page4() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Text(
            "I am interested in (select all that apply)",
            style:
            GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w100),
          ),
          SizedBox(
            height: 30.0,
          ),
          GridView.count(
            physics: ScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(right: 30, left: 30),
            mainAxisSpacing: 8,
            children: interestsOptions.map((imageName) {
              return GestureDetector(
                onTap: () {
                  if (userData.userInterest.contains(imageName)) {
                    setState(() {
                      userData.userInterest.remove(imageName);
                    });
                  } else if (!userData.userInterest.contains(imageName)) {
                    setState(() {
                      userData.userInterest.add(imageName);
                    });
                  }
                },
                child: GridViewItem(
                    imageName,
                    userData.userInterest.contains(imageName),
                    interestsColorsMap[imageName]),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  bool validation() {
    switch(currentPage) {
      case 0:
        if (userData.name != null) {
          currentPage++;
          return true;
        } else {
          _showDialog("Please fill in all the fields. The email and password must be in a valid format.");
          return false;
        }
        break;
      case 1:
        if (agreedToTerms & (userData.phoneNumber != null) & (userData.ageRange != null) & (userData.zipCode != null)) {
          currentPage++;
          return true;
        } else {
          _showDialog("Please fill in all the fields and accept the terms.");
          return false;
        }
        break;
      case 2:
        if (userData.userResources.isNotEmpty) {
          currentPage++;
          return true;
        } else {
          _showDialog("Please select at least one option.");
          return false;
        }
        break;
      default:
        return false;
    }
  }

  void _showDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter the correct format"),
            content: Text(errorMessage),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                  });
                },
              )
            ],
          );
        });
  }
}


