import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/screens/home/side_menu.dart';
import 'package:chodiapp/screens/home/tab_pages/for_you_tab/for_you_page.dart';
import 'package:chodiapp/screens/home/tab_pages/v2_events_tab/v2_events_page_search.dart';
import 'package:flutter/material.dart';
import 'tab_pages/impact_tab/impact_page.dart';
import 'tab_pages/messages_tab/messages_page.dart';
import 'tab_pages/notifications_tab/notifications_page.dart';

class v2_AuthenticatedHomeScreen extends StatefulWidget {
  @override
  _v2_AuthenticatedHomeScreenState createState() =>
      _v2_AuthenticatedHomeScreenState();
}

class _v2_AuthenticatedHomeScreenState
    extends State<v2_AuthenticatedHomeScreen> {
  bool loading = false;
  List<Color> selectedColors = [
    Colors.yellow,
    Colors.orange[600],
    Colors.red,
    Colors.blue,
    Colors.green
  ];
  int _selectedIndex = 2;
  List<Widget> _widgetOptions = <Widget>[
    ImpactPage(),
    v2_EventsPageSearch(),
    ForYouPage(),
    MessagesPage(),
    NotificationsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

    return Scaffold(
      drawer: SideMenu(),
//       appBar: AppBar(
// //        leading: IconButton(
// //            icon: Icon(Icons.menu),
// //            onPressed: () async{
// //              setState(() {
// //                loading = true;
// //              });
// //              await _auth.signOut();
// //
// //            }
// //        ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               Navigator.of(context).pushNamed('searchPage');
//             },
//           )
//         ],
//
//         title: Center(
//           child: RichText(
//               text: new TextSpan(
//                   style: new TextStyle(
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: 1.0),
//                   children: <TextSpan>[
//                 new TextSpan(
//                     text: "C", style: new TextStyle(color: Colors.yellow)),
//                 new TextSpan(
//                     text: "H", style: new TextStyle(color: Colors.orange)),
//                 new TextSpan(
//                     text: "O", style: new TextStyle(color: Colors.red)),
//                 new TextSpan(
//                     text: "D", style: new TextStyle(color: Colors.blue)),
//                 new TextSpan(
//                     text: "I", style: new TextStyle(color: Colors.green)),
//               ])),
//         ),
//         backgroundColor: appBarColor,
//       ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Impact',
              style: labelStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text(
              'Events',
              style: labelStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'For You',
              style: labelStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text(
              'Messages',
              style: TextStyle(fontSize: 14),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text(
              'Notifications',
              style: labelStyle,
            ),
          ),
        ],
        backgroundColor: appBarColor,
        iconSize: 25.0,
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: selectedColors[_selectedIndex],
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
