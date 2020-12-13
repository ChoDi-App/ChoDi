import 'package:chodiapp/screens/home/side_menu.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_RSVPd.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_Liked.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_Explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsPageSearch extends StatefulWidget {
  @override
  _EventsPageSearch createState() => _EventsPageSearch();
}

class _EventsPageSearch extends State<EventsPageSearch> {
  // Used to open LeftSide Profile Drawer
  final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

  // Used for tab control
  final List<Tab> page_tabs = <Tab>[
    Tab(text: 'RSVP'),
    Tab(text: 'Likes'),
    Tab(text: 'Explore')
  ];
  var _clearTextField = TextEditingController();
  var sharedScrollController;

  // User for searching
  bool searching = false;
  bool filtersShown = false;
  bool filtering = false;
  String aQuery = "";
  final List<searchFilterChip> searchFilters = <searchFilterChip>[
    searchFilterChip(chipName: 'Near Me'),
    searchFilterChip(chipName: 'My Interests'),
    searchFilterChip(chipName: 'My Communities')
  ];

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
            controller: sharedScrollController,
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
                            Icons.menu_rounded,
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
                                aQuery = "";
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
                        // leadingWidth: 30,
                        // // Filter Selection Button
                        // leading: (IconButton(
                        //   iconSize: 30,
                        //   padding: EdgeInsets.all(12),
                        //   icon: Icon(Icons.filter_list_rounded),
                        //   color: (!filtering)
                        //       ? Colors.black54
                        //       : Colors.orange[400],
                        //   splashColor: Colors.transparent,
                        //   onPressed: () {
                        //     setState(() {
                        //       filtersShown = !filtersShown;
                        //     });
                        //   },
                        // )),
                        title: TextField(
                          controller: _clearTextField,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            setState(() {
                              aQuery = text;
                            });
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
                                setState(() {
                                  aQuery = "";
                                  _clearTextField.clear();
                                });
                              },
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),

                        // expandedHeight: (filtersShown) ? 180 : null,
                        // flexibleSpace: (filtersShown)
                        //     ? Container(
                        //         child: Padding(
                        //           padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
                        //           child: Wrap(
                        //             spacing: 5,
                        //             runSpacing: 3,
                        //             children: searchFilters,
                        //           ),
                        //         ),
                        //       )
                        //     : SizedBox(),

                        actions: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  aQuery = "";
                                  searching = false;
                                  _clearTextField.clear();
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
                      )
                    ];
            },
            // This GestureDetector will close keyboard when scrolling down
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
                  RSVP(query: aQuery),
                  Liked(aQuery),
                  ExplorePage(query: aQuery),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class searchFilterChip extends StatefulWidget {
  final String chipName;
  bool selected;

  @override
  searchFilterChip({@required this.chipName});

  @override
  State<StatefulWidget> createState() => _searchFilterChip();
}

class _searchFilterChip extends State<searchFilterChip> {
  var _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle:
          TextStyle(color: (!_isSelected) ? Colors.black54 : Colors.white),
      selectedColor: Colors.orange[400],
      showCheckmark: false,
      selected: _isSelected,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
    );
  }
}
