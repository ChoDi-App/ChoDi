import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/screens/home/search_page/filter_result.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_InfoPage.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_QRCodePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:chodiapp/models/events.dart';

class v2_AgendaCalendar extends StatefulWidget {
  var scrollController;
  v2_AgendaCalendar({this.scrollController});

  @override
  _v2_AgendaCalendarState createState() => _v2_AgendaCalendarState();
}

class _v2_AgendaCalendarState extends State<v2_AgendaCalendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> regEventList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);

    final textColor1 = Colors.black;
    final textColor2 = Colors.black87;
    var h1 = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: textColor1);
    var h2 = TextStyle(fontSize: 14, color: textColor2);
    final regText = TextStyle(fontSize: 14, height: 1.3, color: textColor2);

    void showRSVPInfo({Events event}) {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: .95,
              maxChildSize: 1,
              minChildSize: .80,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return v2_QRCodePage(
                    event: event, scrollController: scrollController);
              },
            );
          });
    }

    void showOptions({Events event}) {
      showModalBottomSheet(
          isDismissible: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: .50,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TextButton(
                          child: Text(
                            "View Event Details",
                            textAlign: TextAlign.center,
                            style: h1,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      v2_EventsInfoPage(event: event)),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          child: Text(
                            "View RSVP Information",
                            textAlign: TextAlign.center,
                            style: h1,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            showRSVPInfo(event: event);
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          });
    }

    if (currentUser != null) {
      regEventList = eventsList.where((someEvent) {
        return currentUser.registeredEvents.contains(someEvent.ein);
      }).toList();
    }

    for (Events e in regEventList) {
      if (_events[DateTime.parse(e.eventDate.startStamp.toDate().toString())] !=
              null &&
          !_events[DateTime.parse(e.eventDate.startStamp.toDate().toString())]
              .contains(e))
        _events[DateTime.parse(e.eventDate.startStamp.toDate().toString())]
            .add(e);
      else
        _events[DateTime.parse(e.eventDate.startStamp.toDate().toString())] = [
          e
        ];
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            color: Colors.white,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            controller: widget.scrollController,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.expand_more_rounded,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 50),
                          Text(
                            'Agenda',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            color: Colors.yellow[600],
                            onPressed: () {
                              setState(() {
                                if (_controller.calendarFormat ==
                                    CalendarFormat.week)
                                  _controller
                                      .setCalendarFormat(CalendarFormat.month);
                                else
                                  _controller
                                      .setCalendarFormat(CalendarFormat.week);
                              });
                            },
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    TableCalendar(
                      events: _events,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarController: _controller,
                      initialCalendarFormat: CalendarFormat.week,
                      headerStyle: HeaderStyle(
                        centerHeaderTitle: true,
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                          selectedColor: Colors.yellow[600],
                          selectedStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                          todayColor: Colors.grey[300],
                          todayStyle: TextStyle()),
                      onDaySelected: (date, event, holidays) {
                        setState(() {
                          if (!event.isEmpty)
                            _selectedEvents = event;
                          else
                            _selectedEvents = [];
                        });
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    ListView.builder(
                      itemCount: _selectedEvents.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                              _selectedEvents.cast<Events>()[index].eventName),
                          trailing: IconButton(
                            icon: Icon(Icons.more_horiz),
                            onPressed: () {
                              showOptions(
                                  event: _selectedEvents.cast<Events>()[index]);
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
