import 'package:flutter/material.dart';
import 'package:chodiapp/constants/TextStyles.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Index 4: Notifications Page SIGNED IN',
        style: optionStyle,
      ),
    );
  }
}
