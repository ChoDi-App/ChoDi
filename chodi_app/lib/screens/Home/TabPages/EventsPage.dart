import 'package:flutter/material.dart';
import 'package:chodiapp/constants/TextStyles.dart';


class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Index 1: events page SIGNED IN ',
        style: optionStyle,
      ),
    );
  }
}
