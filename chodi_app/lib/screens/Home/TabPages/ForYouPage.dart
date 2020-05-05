import 'package:chodiapp/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/TextStyles.dart';
import 'package:provider/provider.dart';

class ForYouPage extends StatefulWidget {
  @override
  _ForYouPageState createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context) ?? UserData();
    return Container(
      child: Text(
        'Index 2: For You Page SIGNED IN: ${userData.name}',
        style: optionStyle,
      ),
    );
  }
}
