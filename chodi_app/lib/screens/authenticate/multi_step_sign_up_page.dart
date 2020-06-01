import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/services/auth.dart';
import 'package:chodiapp/services/firestore.dart';
import 'package:chodiapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_page_form/multi_page_form.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class MultiStepSignUpPage extends StatefulWidget {
  @override
  _MultiStepSignUpPageState createState() => _MultiStepSignUpPageState();
}

class _MultiStepSignUpPageState extends State<MultiStepSignUpPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  UserData userData = UserData(userResources: [], userInterest: []);
  String email = "";
  String password = "";
  List<dynamic> userResources = [];
  List<dynamic> userInterest = [];

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

  StepperType stepperType = StepperType.vertical;


  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String _validatePassword(String value) {
    Pattern pattern =
        r'^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value))
      return "Enter Stronger Password";
    else
      return null;
  }

  Future<User> _registerIndividualUser(BuildContext context, String email,
      String password, UserData userData) async {
    try {
      User user = await AuthService().registerWithEmailAndPassword(
          email, password);
      await FirestoreService(uid: user.uid).createIndividualUser(userData);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != 4
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
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
                child: Column(
                  children: [
                    complete ? Expanded(
                      child: Center(
                        child: AlertDialog(
                          title: new Text("Done"),
                          content: Text(
                              "Thank you please submit sign up form."),
                          actions: [
                            FlatButton(
                              child: Text("NO"),
                              onPressed: () {
                                setState(() {
                                  complete = false;
                                });
                              },
                            ),
                            FlatButton(
                              child: Text("YES"),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (userData.userInterest.isNotEmpty &&
                                      userData.userResources.isNotEmpty) {
                                    if (userData.ageRange != null) {
                                      if (agreedToTerms) {
                                        setState(() {
                                          loading = true;
                                        });
                                        try {
                                          dynamic result =
                                          _registerIndividualUser(context,
                                              email, password, userData);
                                          if (result == null){
                                            setState(() {
                                              loading = false;
                                            });
                                          }
                                        }
                                        catch (e) {
                                          print(e.toString());
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      }
                                      if (agreedToTerms == false) {
                                        print("Please Agree to Terms");
                                        showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Notice"),
                                                content: Text(
                                                    "Please make sure to accept terms of use and privacy policy "),
                                                actions: [
                                                  FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        complete = false;
                                                      });
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                    }
                                    if (userData.ageRange == null) {
                                      print("Please Select an Age Range");
                                      showDialog(context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Notice"),
                                              content: Text(
                                                  "Please make sure you select an age range to continue"),
                                              actions: [
                                                FlatButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      complete = false;
                                                    });
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  }
                                  if (userData.userInterest.isEmpty ||
                                      userData.userResources.isEmpty) {
                                    print(
                                        "Please fill select and interest and or donations");
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Notice"),
                                            content: Text(
                                                "Please make sure you select what you can provide and your interests, must select at a least one option of each to continue."),
                                            actions: [
                                              FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    complete = false;
                                                  });
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                }
                              },
                            )
                          ],

                        ),
                      ),
                    )
                        : Expanded(
                      child: Stepper(
                        type: stepperType,
                        currentStep: currentStep,
                        onStepContinue: next,
                        onStepTapped: (step) => goTo(step),
                        onStepCancel: cancel,
                        steps: [
                          Step(
                            title: new Text("New Account"),
                            isActive: currentStep == 0,
                            state: StepState.indexed,
                            content: Column(
                              children: [
                                TextFormField(
                                  validator: (val) =>
                                  val.isEmpty ? 'Enter a Name ' : null,
                                  decoration: InputDecoration(
                                      labelText: "First and Last Name"),
                                  onChanged: (val) {
                                    setState(() {
                                      userData.name = val;
                                    });
                                  },
                                ),
                                TextFormField(
                                  validator: _validateEmail,
                                  decoration:
                                  InputDecoration(labelText: "Email"),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                                TextFormField(
                                  validator: _validatePassword,
                                  decoration: InputDecoration(
                                      labelText: "Password"),
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Step(
                              isActive: currentStep == 1,
                              state: StepState.indexed,
                              title: new Text("Personal Information"),
                              content: Column(
                                children: [
                                  TextFormField(
                                    validator: (val) =>
                                    val.isEmpty
                                        ? 'Enter a Number '
                                        : null,
                                    decoration: InputDecoration(
                                        labelText: "Phone Number"),
                                    keyboardType:
                                    TextInputType.numberWithOptions(),
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
                                  TextFormField(
                                    validator: (val) =>
                                    val.isEmpty
                                        ? 'Enter Zip Code'
                                        : null,
                                    decoration: InputDecoration(
                                        labelText: "Zip Code"),
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) {
                                      setState(() {
                                        userData.zipCode = val;
                                      });
                                    },
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
                              )),
                          Step(
                            state: StepState.indexed,
                            title:
                            new Text("What do you wish to provide?"),
                            isActive: currentStep == 2,
                            content: GridView.count(
                              physics: ScrollPhysics(),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 1.0,
                              padding: EdgeInsets.only(right: 30, left: 30),
                              mainAxisSpacing: 8,
                              children: resourcesOptions.map((imageName) {
                                return GestureDetector(
                                  onTap: () {
                                    if (userData.userResources.contains(
                                        imageName)) {
                                      setState(() {
                                        userData.userResources.remove(
                                            imageName);
                                      });
                                    }
                                    else if (!userData.userResources.contains(
                                        imageName)) {
                                      setState(() {
                                        userData.userResources.add(imageName);
                                      });
                                    }
                                    print(userData.userResources);
                                  },
                                  child: GridViewItem(imageName,
                                      userData.userResources.contains(
                                          imageName),
                                      donationsColorsMap[imageName]),
                                );
                              }).toList(),
                            ),
                          ),
                          Step(
                            isActive: currentStep == 3,
                            state: StepState.indexed,
                            title: new Text("What are your interests?"),
                            content: GridView.count(
                              physics: ScrollPhysics(),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 1.0,
                              padding: EdgeInsets.only(right: 30, left: 30),
                              mainAxisSpacing: 8,
                              children: interestsOptions.map((imageName) {
                                return GestureDetector(
                                  onTap: () {
                                    if (userData.userInterest.contains(
                                        imageName)) {
                                      setState(() {
                                        userData.userInterest.remove(imageName);
                                      });
                                    }
                                    else if (!userData.userInterest.contains(
                                        imageName)) {
                                      setState(() {
                                        userData.userInterest.add(imageName);
                                      });
                                    }
                                  },
                                  child: GridViewItem(imageName,
                                      userData.userInterest.contains(imageName),
                                      interestsColorsMap[imageName]),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class GridViewItem extends StatelessWidget {
  final String _imageName;
  final bool _isSelected;
  final Color backColor;

  GridViewItem(this._imageName, this._isSelected, this.backColor);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageIcon(AssetImage("images/${_imageName}.png",),
              color: !_isSelected ? Colors.black : backColor,
              size: 50,),
            Text(_imageName,
              style: GoogleFonts.ubuntu(fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    );
  }
}
