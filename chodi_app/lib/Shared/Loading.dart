import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 20.0,
        ),
      ),
    );
  }
}