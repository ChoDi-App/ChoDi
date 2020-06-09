import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/services/auth.dart';
import 'package:chodiapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  bool success;


  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid Email";
    }
    return null;
  }

  Future _sendResetPasswordEmail(String email) async {
    final auth = Provider.of<AuthService>(context, listen: false);
    await auth.resetPassword(email);
  }

  void _showDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Notice"),
            content: Text(errorMessage),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  if (success){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                  else{
                    Navigator.of(context).pop();
                  }

                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Material(
      child: CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Reset Password",
            style:
            GoogleFonts.ubuntu(fontWeight: FontWeight.w100, fontSize: 25),
          ),
          border: Border(bottom: BorderSide.none),
        ),
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
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        "An instructional email will be sent to that on how to reset password",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w100,
                            fontSize: 17.0,
                            color: Colors.grey)),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "Email Address",
                        labelText: "Email Address",
                      ),
                      validator: _validateEmail,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                      child: Text("Submit",
                        style: GoogleFonts.ubuntu(fontSize: 22, color: Colors
                            .blue),),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            setState(() {
                              loading = true;
                            });
                            await _sendResetPasswordEmail(email);
                            setState(() {
                              loading = false;
                              success = true;
                            });
                            _showDialog(
                                "Sucess please check email inbox for further instructions");
                          } catch (e) {
                            setState(() {
                              loading = false;
                              success = false;
                            });
                            _showDialog(e.message);
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
    );
  }
}
