import 'package:flutter/material.dart';


class InfoPageButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;
  
  InfoPageButton({this.onPressed, @required this.title, @required this.color});
  
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(title),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
