import 'package:chodiapp/screens/home/side_menu.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_RSVPd.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_Liked.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_Explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class v2_EventsPageSearch extends StatefulWidget {
  @override
  _v2_EventsPageSearch createState() => _v2_EventsPageSearch();
}

class _v2_EventsPageSearch extends State<v2_EventsPageSearch> {
  final List<Tab> page_tabs = <Tab>[
    Tab(text: 'RSVP'),
    Tab(text: 'Likes'),
    Tab(text: 'Explore')
  ];
  final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();
  bool searching = false;
  String aQuery = "";
  var _clearTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: drawerKey,
        drawer: SideMenu(),
        backgroundColor: Colors.white70,
        body: DefaultTabController(
          length: page_tabs.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return (!searching)
                  ? <Widget>[
                      SliverAppBar(
                        elevation: 10,
                        backgroundColor: Colors.white,
                        floating: true,
                        pinned: true,
                        snap: true,
                        leading: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black54,
                          ),
                          onPressed: () => drawerKey.currentState.openDrawer(),
                        ),
                        title: Text(
                          'Events',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.black87,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                searching = true;
                              });
                            },
                          )
                        ],
                        bottom: TabBar(
                          unselectedLabelColor: Colors.grey[500],
                          labelColor: Colors.grey[700],
                          indicatorColor: Colors.grey[700],
                          tabs: page_tabs,
                        ),
                      ),
                    ]
                  : <Widget>[
                      SliverAppBar(
                        elevation: 10,
                        backgroundColor: Colors.white,
                        floating: true,
                        pinned: true,
                        snap: true,
                        automaticallyImplyLeading: false,
                        title: TextField(
                          controller: _clearTextField,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            aQuery = text;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            suffixIcon: IconButton(
                              color: Colors.grey[400],
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                aQuery = "";
                                _clearTextField.clear();
                                setState(() {});
                              },
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  searching = false;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ))
                        ],
                        bottom: TabBar(
                          unselectedLabelColor: Colors.grey[500],
                          labelColor: Colors.grey[700],
                          indicatorColor: Colors.grey[700],
                          tabs: page_tabs,
                        ),
                      ),
                    ];
            },
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: TabBarView(
                children: [
                  // Container(
                  //   child: Text('Something'),
                  // ),
                  v2_RSVP(aQuery),
                  v2_Liked(aQuery),
                  v2_ExplorePage(aQuery),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
