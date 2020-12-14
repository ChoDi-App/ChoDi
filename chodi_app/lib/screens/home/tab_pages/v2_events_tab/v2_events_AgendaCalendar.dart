import 'dart:developer';

import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_InfoPage.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_QRCodePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:chodiapp/models/events.dart';

class v2_AgendaCalendar extends StatefulWidget {
  var scrollController;
  StartingDayOfWeek _startingDayOfWeek;
  v2_AgendaCalendar({this.scrollController});

  @override
  _v2_AgendaCalendarState createState() => _v2_AgendaCalendarState();
}

class _v2_AgendaCalendarState extends State<v2_AgendaCalendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _eventsByDay;

  List<dynamic> _selectedEvents;
  bool _monthView = false;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventsByDay = {};
    _selectedEvents = [];
    widget._startingDayOfWeek = StartingDayOfWeek.sunday;
  }

  @override
  Widget build(BuildContext context) {
    List<Events> eventsList = Provider.of<List<Events>>(context);
    List<Events> regEventList = new List<Events>();
    UserData currentUser = Provider.of<UserData>(context);

    final textColor1 = Colors.black;
    final textColor2 = Colors.black87;
    var h1 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.3, color: textColor1);
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
              builder: (BuildContext context, ScrollController scrollController) {
                return v2_QRCodePage(event: event, scrollController: scrollController);
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
              builder: (BuildContext context, ScrollController scrollController) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                              MaterialPageRoute(builder: (context) => v2_EventsInfoPage(event: event)),
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
      String s = e.eventDate.startStamp.toDate().toString();
      log("adding $s -- > ${DateTime.parse(s)}");
      if (_eventsByDay[DateTime.parse(s)] != null && !_eventsByDay[DateTime.parse(s)].contains(e))
        _eventsByDay[DateTime.parse(s)].add(e);
      else
        _eventsByDay[DateTime.parse(s)] = [e];
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
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            color: (!_monthView) ? Colors.grey : Colors.orange[400],
                            onPressed: () {
                              setState(() {
                                _monthView = !_monthView;
                                if (_controller.calendarFormat == CalendarFormat.week)
                                  _controller.setCalendarFormat(CalendarFormat.month);
                                else
                                  _controller.setCalendarFormat(CalendarFormat.week);
                              });
                            },
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    TableCalendar(
                      startingDayOfWeek: widget._startingDayOfWeek,
                      events: _eventsByDay,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarController: _controller,
                      initialCalendarFormat: CalendarFormat.week,
                      headerStyle: HeaderStyle(
                        centerHeaderTitle: true,
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                          selectedColor: Colors.orange[400],
                          selectedStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                          todayColor: Colors.grey[300],
                          todayStyle: TextStyle()),
                      onDaySelected: (date, event, holidays) {
                        setState(() {
                          _selectedEvents = [];
                          getEventsThisWeek(date, _eventsByDay, _selectedEvents);
                          // if (!event.isEmpty)
                          //   _selectedEvents = event;
                          // else
                          //   _selectedEvents = [];
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
                          title: Text(_selectedEvents.cast<Events>()[index].eventName),
                          trailing: IconButton(
                            icon: Icon(Icons.more_horiz),
                            onPressed: () {
                              showOptions(event: _selectedEvents.cast<Events>()[index]);
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

  getEventsThisWeek(DateTime day, Map<DateTime, List<dynamic>> eventsByDay, List<dynamic> allEvents) {
    if (allEvents == null) allEvents = [];

    switch (day.weekday) {
      case DateTime.saturday:
        {
          getEventsThisWeek(day.subtract(Duration(days: 6)), eventsByDay, allEvents);
          break;
        }
      case DateTime.friday:
        {
          getEventsThisWeek(day.subtract(Duration(days: 5)), eventsByDay, allEvents);
          break;
        }
      case DateTime.thursday:
        {
          getEventsThisWeek(day.subtract(Duration(days: 4)), eventsByDay, allEvents);
          break;
        }
      case DateTime.wednesday:
        {
          getEventsThisWeek(day.subtract(Duration(days: 3)), eventsByDay, allEvents);
          break;
        }
      case DateTime.tuesday:
        {
          getEventsThisWeek(day.subtract(Duration(days: 2)), eventsByDay, allEvents);
          break;
        }
      case DateTime.monday:
        {
          getEventsThisWeek(day.subtract(Duration(days: 1)), eventsByDay, allEvents);
          break;
        }
      case DateTime.sunday:
        {
          log("this sunday: ${day}");
          _addEventsToList(day, eventsByDay, allEvents);
          _addEventsToList(day.add(Duration(days: 1)), eventsByDay, allEvents);
          _addEventsToList(day.add(Duration(days: 2)), eventsByDay, allEvents);
          _addEventsToList(day.add(Duration(days: 3)), eventsByDay, allEvents);
          _addEventsToList(day.add(Duration(days: 4)), eventsByDay, allEvents);
          _addEventsToList(day.add(Duration(days: 5)), eventsByDay, allEvents);
          _addEventsToList(day.add(Duration(days: 6)), eventsByDay, allEvents);

          log("final list: ${allEvents}");
          break;
        }
    }
    return allEvents;
  }

  _addEventsToList(DateTime day, Map<DateTime, List<dynamic>> eventsByDay, List<dynamic> target) {
    DateTime datetime = _formatDayTime(day);
    if (_eventsByDay[datetime] != null) {
      log(" has events!");
      for (dynamic d in _eventsByDay[datetime]) {
        log(" adding ${_eventsByDay[datetime]}");
        target.add(d);
      }
    }
  }

  DateTime _formatDayTime(DateTime day) {
    String s = "${day.year}-";
    s += (day.month > 9) ? "${day.month}-" : "0${day.month}-";
    s += (day.day > 9) ? "${day.day} 00:00:00.000" : "0${day.day} 00:00:00.000";
    return DateTime.parse(s);
  }
}
