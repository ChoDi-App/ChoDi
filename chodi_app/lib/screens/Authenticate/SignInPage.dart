import 'package:flutter/material.dart';
import 'package:chodiapp/Services/Auth.dart';
import 'package:chodiapp/Shared/Loading.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Container(
      child: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Sign In"),
              onPressed:() async {
                setState(() {
                  loading = true;
                });
                dynamic result = await _auth.signInAnon();
                if (result != null){
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
            SizedBox(),
            FlatButton(
              child: Text("Sign Out"),
              onPressed: _auth.signOut,
            )
          ],
        ),
      ),
    );
  }
}
