import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  Icon icon;
  Text textWidget;
  InfoRow({this.icon, this.textWidget});

  @override
  Widget build(BuildContext context) {
    Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 8,
        ),
        textWidget
      ],
    );
  }
}
