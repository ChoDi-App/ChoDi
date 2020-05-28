import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    //print(eventsList[0].events)
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: eventsList.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return EventsCard(
            event: eventsList[index],
          );
        },
      ),
    );
  }
}
