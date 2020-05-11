import 'package:flutter/material.dart';
import 'package:chodiapp/constants/TextStyles.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Index 3: Messages Page SIGNED IN',
        style: optionStyle,
      ),
    );
  }
}
