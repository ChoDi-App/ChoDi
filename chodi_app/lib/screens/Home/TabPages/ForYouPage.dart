import 'package:flutter/material.dart';
import 'package:chodiapp/constants/TextStyles.dart';

class ForYouPage extends StatefulWidget {
  @override
  _ForYouPageState createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Index 2: For You Page SIGNED IN',
        style: optionStyle,
      ),
    );
  }
}
