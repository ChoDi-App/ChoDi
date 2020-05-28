import 'package:flutter/material.dart';
import 'package:chodiapp/Services/auth.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:chodiapp/models/user.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  FocusNode _focusNodeEmail;
  FocusNode _focusNodePassword;
  String email = "";
  String password = "";
  bool _validEmail = true;
  bool _validPassword = true;
  bool _signInFailed = false;

  Future<User> _signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      return await auth.signInWithEmailAndPassword(email, password);
    } catch (e) {
      print("Here:" + e.toString());
      return null;
    }
  }

  Future<User> _signInWithGoogle() async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      return await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  void initState() {
    _focusNodeEmail = new FocusNode();
    _focusNodePassword = new FocusNode();

    _focusNodeEmail.addListener(() {
      if (!_focusNodeEmail.hasFocus) {
        if (_validateEmail(email)) {
          _validEmail = true;
        } else {
          _validEmail = false;
        }
      }
    });

    _focusNodePassword.addListener(() {
      if (!_focusNodePassword.hasFocus) {
        if (_validatePassword(password)) {
          _validPassword = true;
        } else {
          _validPassword = false;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
  }

  bool _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value);
  }

  bool _validatePassword(String value) {
    return value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Sign In",
            style:
                GoogleFonts.ubuntu(fontWeight: FontWeight.w100, fontSize: 25),
          ),
          border: Border(bottom: BorderSide.none),
        ),
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        title: Text("Sign In",
//          style: GoogleFonts.ubuntu(fontSize: 25.0, fontWeight: FontWeight.w300,)),
//      ),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                      ),
                      Text(
                          "To use these features please sign in or sign up. Thanks.",
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w100,
                              fontSize: 17.0,
                              color: Colors.grey)),
                      Visibility(
                        child: Text(
                          "The email or password you entered is incorrect.",
                          style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        visible: _signInFailed,
                      ),
                      Column(
                        children: <Widget>[
                          TextFormField(
                            focusNode: _focusNodeEmail,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Email Address",
                                labelText: "Email Address",
                                errorText: _validEmail
                                    ? null
                                    : "Please enter a valid email"),
                            onFieldSubmitted: (val) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodePassword);
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          TextFormField(
                            focusNode: _focusNodePassword,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Password",
                                labelText: "Password",
                                errorText: _validPassword
                                    ? null
                                    : "Please enter a valid password"),
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          )
                        ],
                      ),
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          bool checkEmail = _validateEmail(email);
                          bool checkPassword = _validatePassword(password);
                          if (checkEmail & checkPassword) {
                            _validEmail = true;
                            _validPassword = true;
                            User result = await _signInWithEmailAndPassword(
                                context, email, password);
                            if (result == null) {
                              _signInFailed = true;
                              print("Couldn't sign in with those credentials");
                              setState(() {
                                loading = false;
                              });
                            }
                          } else {
                            if (!checkPassword) {
                              _validPassword = false;
                            } else {
                              _validPassword = true;
                            }
                            if (!checkEmail) {
                              _validEmail = false;
                            } else {
                              _validEmail = true;
                            }
                          }
                        },
                        child: Text(
                          "Log In",
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w100,
                              color: Colors.blue,
                              fontSize: 22),
                        ),
                      ),
                      Text(
                        "OR",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w100,
                            color: Colors.grey,
                            fontSize: 15),
                      ),
                      RaisedButton(
                        color: Color.fromRGBO(78, 174, 255, 10),
                        padding: EdgeInsets.all(8.0),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          User result = await _signInWithGoogle();
                          if (result == null) {
                            print("Couldn't sign in with those credentials");
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Image.asset(
                                'images/google-icon.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Continue with Google",
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Don't Have an Account?",
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w100, fontSize: 12),
                          ),
                          FlatButton(
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.blue),
                            ),
                            onPressed: () {
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
        ),
      ),
    );
  }
}
