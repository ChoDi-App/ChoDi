import 'package:chodiapp/screens/home/side_menu.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_RSVPd.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_Liked.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_Explore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class v2_EventsPage extends StatefulWidget {
  @override
  _v2_EventsPageState createState() => _v2_EventsPageState();
}

class _v2_EventsPageState extends State<v2_EventsPage> {
  final List<Tab> page_tabs = <Tab>[
    Tab(text: 'RSVP'),
    Tab(text: 'Likes'),
    Tab(text: 'Explore')
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: DefaultTabController(
          length: page_tabs.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    leading: IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        drawer:
                        SideMenu();
                      },
                    ),
                    title: Text(
                      'Events',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    elevation: 10,
                    backgroundColor: Colors.white,
                    floating: true,
                    pinned: true,
                    snap: true,
                    bottom: TabBar(
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.grey[700],
                      indicatorColor: Colors.grey[700],
                      tabs: page_tabs,
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Text('Column2, Item1'),
                    Text('Column2, Item2'),
                    Text('Column2, Item3'),
                  ],
                ),
                v2_Liked(),
                v2_ExplorePage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
