import 'dart:developer';
import 'package:geolocator/geolocator.dart';

import 'package:chodiapp/screens/home/side_menu.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_RSVPd.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_Liked.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_Explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class v2_EventsPageSearch extends StatefulWidget {
  @override
  _v2_EventsPageSearch createState() => _v2_EventsPageSearch();

  // Used for searching
  bool searching = false;
  String aQuery = "";

  // Used for filtering
  Position userPosition;
  bool locationAlreadySet = false;
  bool filtersShown = false;
  bool filtering = false;
  final List<searchFilterChip> searchFilters = <searchFilterChip>[
    searchFilterChip(chipName: 'Near Me'),
    searchFilterChip(chipName: 'My Interests'),
    searchFilterChip(chipName: 'My Communities')
  ];
}

class _v2_EventsPageSearch extends State<v2_EventsPageSearch> {
  // Used to open LeftSide Profile Drawer
  final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

  // Used for tab control
  final List<Tab> page_tabs = <Tab>[Tab(text: 'RSVP'), Tab(text: 'Likes'), Tab(text: 'Explore')];
  var _clearTextField = TextEditingController();
  var sharedScrollController;

  @override
  Widget build(BuildContext context) {
    // Get's User position when entering tab
    // (ideally, position would already be set in case for
    //    other use in other tabs)
    if (!widget.locationAlreadySet) {
      _determinePosition().then((value) {
        widget.userPosition = value;
        log(widget.userPosition.toString());
        widget.locationAlreadySet = true;
      });
    }

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
              return (!widget.searching)
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
                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
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
                                widget.aQuery = "";
                                widget.searching = true;
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
                        // automaticallyImplyLeading: false,
                        leadingWidth: 40,
                        // Filter Selection Button
                        leading: (IconButton(
                          iconSize: 30,
                          padding: EdgeInsets.all(12),
                          icon: Icon(Icons.filter_list_rounded),
                          color: (!widget.filtering) ? Colors.black54 : Colors.orange[400],
                          splashColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              widget.filtersShown = !widget.filtersShown;
                            });
                          },
                        )),
                        title: TextField(
                          controller: _clearTextField,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            setState(() {
                              widget.aQuery = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
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
                                  widget.aQuery = "";
                                  _clearTextField.clear();
                                });
                              },
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),

                        expandedHeight: (widget.filtersShown) ? 200 : null,
                        flexibleSpace: (widget.filtersShown)
                            ? Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
                                  child: Column(
                                    children: [
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 5,
                                        runSpacing: 3,
                                        children: widget.searchFilters,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.filtersShown = false;
                                            widget.filtering = determineIfFiltering(widget.searchFilters);
                                          });
                                        },
                                        child: Text(
                                          "Apply Changes",
                                          style: TextStyle(color: Colors.orange[400]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),

                        actions: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.aQuery = "";
                                  widget.searching = false;
                                  widget.filtering = false;
                                  widget.filtersShown = false;
                                  _clearFilters(widget.searchFilters);
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
                  v2_RSVP(query: widget.aQuery),
                  v2_Liked(givenQuery: widget.aQuery),
                  v2_ExplorePage(
                    query: widget.aQuery,
                    userPosition: _determinePosition(),
                    filtering: widget.filtering,
                    filters: widget.searchFilters,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool determineIfFiltering(List<searchFilterChip> filters) {
    for (searchFilterChip f in filters) {
      if (f.selected) return true;
    }
    return false;
  }

  void _clearFilters(List<searchFilterChip> filters) {
    for (searchFilterChip c in filters) {
      c.selected = false;
    }
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      return Future.error('Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}

class searchFilterChip extends StatefulWidget {
  final String chipName;
  bool selected = false;

  @override
  searchFilterChip({@required this.chipName});

  @override
  State<StatefulWidget> createState() => _searchFilterChip();
}

class _searchFilterChip extends State<searchFilterChip> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: (!widget.selected) ? Colors.black54 : Colors.white),
      selectedColor: Colors.orange[400],
      showCheckmark: false,
      selected: widget.selected,
      onSelected: (isSelected) {
        setState(() {
          widget.selected = isSelected;
        });
      },
    );
  }
}
